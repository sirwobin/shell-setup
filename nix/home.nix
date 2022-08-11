{ config, pkgs, lib, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.packages = [ pkgs.fzf pkgs.tmux pkgs.htop-vim pkgs.powerline-go ];
  # pkgs.git

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history.share = false;

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "lein" ];
    };


    localVariables = {
      COMPLETION_WAITING_DOTS = "true";
    };

    shellAliases = {
      l = "ls -lh";
      ll = "ls -lAh";
      m = "less -FnqRX";
      lstgz = "dtrx -l";
      pi = "ssh 192.168.2.10 -t \"tmux attach\"";
      lr = "lein repl";
      lf = "lein figwheel";
    };

    loginExtra =
    ''
      if [[ `uname` = "Linux" && -z "$SSH_CLIENT" ]]; then
        eval $(ssh-agent)
        ssh-add
      fi
    '';

    logoutExtra =
    ''
      ssh-agent -k
    '';
  };

  programs.powerline-go = {
    enable = true;
    settings = {
      hostname-only-if-ssh = true;
      numeric-exit-codes = true;
      cwd-max-depth = 4;
    };
    modules = [ "venv" "user" "host" "ssh" "cwd" ];
    modulesRight = [ "git" "exit" "perms" "nix-shell" "time" ];
  };

  programs.git = {
    enable = true;
    userName = "robin";
    userEmail = "robin108@gmail.com";
    # ignores = [ "" ];

  };
}
