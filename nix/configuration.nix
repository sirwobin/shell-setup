{
  imports = [
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
}
