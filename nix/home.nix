{ config, pkgs, lib, ... }:

{
  home.username = "robin";
  home.homeDirectory = "/home/robin";
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
      tan = "cd ~/projects/tantalus-cljs; nix-shell";
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
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };

  };

  programs.urxvt = {
    enable = true;
    fonts = [ "xft:FantasqueSansMono NF:size=12" ];
    keybindings = { 
      "Shift-Control-C" = "eval:selection_to_clipboard";
      "Shift-Control-V" = "eval:paste_clipboard";
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    extraConfig = ''
      # Use the system clipboard
      set -g set-clipboard on

      # Start copy mode for Shift-Up
      bind -n S-Up copy-mode
      # Paste on Control-]
      bind -n C-] paste-buffer

      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      ##### Status line #####

      # Refresh status line every 5 seconds
      set -g status-interval 5

      # Start window and pane indices at 1.
      set -g base-index 1
      set -g pane-base-index 1

      # length of tmux status line
      set -g status-left-length 10
      # set -g status-right-length 150

      # Make active pane border blue
      set -g pane-active-border-style "fg=blue"

      # Set the left and right status
      set -g status-left '#[bg=colour7]#[fg=colour0]#{?client_prefix,#[bg=colour2],} ❏ #S #[bg=colour8]#[fg=colour7]#{?client_prefix,#[fg=colour2],}#{?window_zoomed_flag, ZOOM ,} '
      # set -g status-right '#[fg=colour2]#(~/dotfiles/tmux_scripts/uptime.sh) #[fg=colour1]#[fg=colour4]#[bg=colour4]#[fg=colour0] #(~/dotfiles/tmux_scripts/music.sh) #[bg=colour4]#[fg=colour7]#[bg=colour7]#[fg=colour0] %b %d %H:%M '
      set -g status-right ""

      # Set the background color
      set -g status-bg colour8

      #colour0 (black)
      #colour1 (red)
      #colour2 (green)
      #colour3 (yellow)
      #colour4 (blue)
      #colour7 (white)
      #colour5 colour6 colour7 colour8 colour9 colour10 colour11 colour12 colour13 colour14 colour15 colour16 colour17

      #D ()
      #F ()
      #H (hostname)
      #I (window index)
      #P()
      #S (session index)
      #T (pane title)
      #W (currnet task like vim if editing a file in vim or zsh if running zsh)

      # customize how windows are displayed in the status line
      set -g window-status-current-format "#[fg=colour8]#[bg=colour4]#[fg=colour7]#[bg=colour4] #I* #[fg=colour7] #{=50:window_name} #[fg=colour4]#[bg=colour8]"
      set -g window-status-format "#[fg=colour244]#[bg=colour8]#I-#[fg=colour240]  #{=50:window_name}"
    '';
  };
}
