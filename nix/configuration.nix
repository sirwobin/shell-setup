{
  imports = [
#      ./sane-extra-config.nix
    <home-manager/nixos>
  ];

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  services.fwupd.enable = true;
  services.udisks2.enable = true;
  services.blueman.enable = true;
  services.onedrive.enable = true;
  programs.steam.enable = true;

  programs.zsh.enable = true;
  # users.extraUsers.nixos.shell = pkgs.zsh;
  # or
  # users.users.robin.shell = pkgs.zsh;

  i18n.defaultLocale = "en_GB.UTF-8";
  #services.localtimed.enable = true;
  time.timeZone = "Europe/Amsterdam";

  # Possibly also VirtualBox guest additions: https://nixos.wiki/wiki/VirtualBox
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.guest.x11 = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable scanner support,
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;
  services.avahi.publish.userServices = true;

  # hardware.sane.extraConfig."pixma" = ''
    # bjnp://192.168.2.24
  # '';

  fonts.packages = with pkgs; [
    fantasque-sans-mono
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Use LightDM for login and no desktop manager
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3.enable = true;

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
    services.sudo.u2fAuth = true;
  };

  # Define a user account.
  users.users.robin = {
    isNormalUser = true;
    description = "Robin L";
    extraGroups = [ "networkmanager" "wheel" "audio" "scanner" "lp" "vboxusers" ];
    shell = pkgs.zsh;
  };

  # Enable automatic login.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "robin";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.localBinInPath = true;
  environment.systemPackages = with pkgs; [
    dunst
    wireguard-tools
    networkmanagerapplet
    blueman
  ];

#  environment.etc = {
#    "wireguard/ivpn_nl3.conf" = {
#      text = ''
#      [Interface]
#      Address = 172.30.245.78/32
#      DNS = 172.16.0.1
#      PrivateKey = <substitute from file>
#      ListenPort = 2049
#      [Peer]
#      PublicKey = XDU6Syq1DY82IMatsHV0x/TAtbLiRwh/SdFCXlEn40c=
#      Endpoint = nl3.wg.ivpn.net:2049
#      AllowedIPs = 0.0.0.0/0
#      '';
#      mode = "0400";
#    };
#  };

  # Allow Canon scanner to be detected.
  networking.firewall.allowedTCPPorts = [ 8612 ];
  # Wireguard port.
  # networking.firewall.allowedUDPPorts = [ 2049 ];

  # Enable virtualbox. Ref <https://nixos.wiki/wiki/Virtualbox>
  virtualisation.virtualbox.host.enable = true;
}
