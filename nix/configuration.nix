# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.kernelParams = [ "mds=off" "tsx_async_abort=off" "nosmt=force" "rfkill.default_state=1" ];
  boot.kernelModules = [ "nouveau" "btusb" ];
  boot.extraModprobeConfig = ''
    options bluetooth disable_ertm=1
    options btusb reset=Y enable_autosuspend=N
  '';
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-fe63103a-dc2b-48ab-84bc-0b6cb03db3f8".device = "/dev/disk/by-uuid/fe63103a-dc2b-48ab-84bc-0b6cb03db3f8";
  boot.initrd.luks.devices."luks-fe63103a-dc2b-48ab-84bc-0b6cb03db3f8".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "rl-nixtop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  boot.supportedFilesystems = [ "ntfs" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.connectionConfig = {
    "wifi.powersave" = lib.mkForce 3;
  };

  # Local hostname lookups
  networking.extraHosts = ''
    192.168.2.10 pi.hole
  '';

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable nix flakes
  nix.package = pkgs.nixVersions.latest;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  services.fwupd.enable = true;
  services.udisks2.enable = true;
  services.blueman.enable = false;
  services.onedrive.enable = true;
  programs.zsh.enable = true;
  # programs.steam.enable = true;

  # Enable Wayland support
  security.polkit.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa
    ];
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    autoLogin.enable = true;
    autoLogin.user = "robin";
  };

  fonts.fontDir.enable = true;
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  # Enable CUPS to print documents.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "cnijfilter2" ];
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.cnijfilter2 ];

  # Enable scanner support,
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;
  services.avahi.publish.userServices = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.dbus.enable = true;
  services.dbus.packages = [ pkgs.bluez ];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
	FastConnectable = true;
        ControllerMode = "dual";
	AutoEnable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  # systemd.targets.bluetooth = {
  #   wantedBy = [ "multi-user.target" ];
  # };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
          bluez_monitor.properties = {
            ["bluez5.enable-sbc-xq"] = true,
            ["bluez5.enable-msbc"] = true,
            ["bluez5.enable-hw-volume"] = true,
            ["bluez5.codecs"] = "[ sbc aac ]",
            ["bluez5.hfp-backend"] = "none",  -- Disable HFP to avoid RFCOMM errors
          }
          
          bluez_monitor.rules = {
            {
              matches = {
                {{ "device.name", "matches", "bluez_card.*" }},
              },
              apply_properties = {
                ["bluez5.auto-connect"] = "[ a2dp_sink ]",
                ["bluez5.profile"] = "a2dp-sink",
              },
            },
          }
      '')
      ];
    };
  };
  
  # Force Bluetooth power on after KDE loads
  systemd.user.services.bluetooth-poweron = {
    description = "Power on Bluetooth adapter";
    after = [ "graphical-session.target" "plasma-plasmashell.service" ];
    wants = [ "plasma-plasmashell.service" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 15";
      ExecStart = "${pkgs.bluez}/bin/bluetoothctl power on";
      RemainAfterExit = true;
    };
  };
  
  # Also set KDE to remember Bluetooth state
  environment.etc."xdg/bluedevilglobalrc".text = ''
    [Global]
    launchState=enable

    [Adapters]
    5C:C5:D4:0D:BA:3C_powered=true
  '';

  # Enable yubikey services and programs
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  security.pam = {
    yubico = {
      enable = true;
      debug = true;
      mode = "challenge-response";
    };
    services = {
      sudo.u2fAuth = true;
      "robin" = {
        kwallet.enable = true;
	kwallet.package = pkgs.kdePackages.kwallet-pam;
      };
      sddm.enableKwallet = true;
      sddm-greeter.enableKwallet = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.robin = {
    isNormalUser = true;
    description = "Robin Lunn";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "scanner" "lp" "vboxusers" "bluetooth" "rtkit" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  # unstable = import <unstable> { config.allowUnfree = true; };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wireguard-tools
    # blueman
    kdePackages.bluedevil
    bluez
    bluez-tools
    ldacbt
    liblc3
    sbc
    fdk_aac
    exfatprogs
  ];
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  environment.localBinInPath = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # Enable virtualbox. Ref <https://nixos.wiki/wiki/Virtualbox>
  # virtualisation.virtualbox.host.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # Allow Canon scanner to be detected.
  networking.firewall.allowedTCPPorts = [ 8612 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
