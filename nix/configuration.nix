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
  programs.zsh.enable = true;
  # users.extraUsers.nixos.shell = pkgs.zsh;
  # or
  # users.users.robin.shell = pkgs.zsh;

  i18n.defaultLocale = "en_GB.UTF-8";
  #services.localtimed.enable = true;
  time.timeZone = "Europe/Amsterdam";

  # Possibly also VirtualBox guest additions: https://nixos.wiki/wiki/VirtualBox
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;

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

  # Use LightDM for login and no desktop manager
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # Define a user account.
  users.users.robin = {
    isNormalUser = true;
    description = "Robin L";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      chromium
      bitwarden
      bitwarden-cli
      kitty
      xsane
    ];
  };

  # Enable automatic login.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "robin";

  # Allow Canon scanner to be detected.
  networking.firewall.allowedTCPPorts = [ 8612 ];
}
