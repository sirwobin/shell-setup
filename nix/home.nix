{ config, pkgs, lib, ... }:

{
  home.username = "robin";
  home.homeDirectory = "/home/robin";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [ neovim lsd fzf btop powerline-go zsh-autosuggestions tree which pulseaudioFull
                               kitty xss-lock firefox chromium gnucash bitwarden bitwarden-cli gscan2pdf tesseract5
                               libreoffice brightnessctl encfs vlc mplayer ranger xclip nomacs xorg.xkbcomp
                               difftastic
  ];

  xresources.properties = {
    "Xft.dpi" = 120;
  };

  xsession.enable = true;
  xsession.profileExtra = ''
    setxkbmap -option compose:menu
    xinput --set-prop "FocalTechPS/2 FocalTech Touchpad" "libinput Accel Speed" 1
  '';

  home.file.".XCompose".text = ''
    include "%L"

    <Multi_key> <g> <a> : "α"
    <Multi_key> <g> <b> : "β"
    <Multi_key> <g> <g> : "γ"
    <Multi_key> <g> <d> : "δ"
    <Multi_key> <g> <e> : "ε"
    <Multi_key> <g> <l> : "λ"
    <Multi_key> <g> <m> : "μ"
    <Multi_key> <g> <p> : "π"
    <Multi_key> <g> <s> : "σ"
    <Multi_key> <g> <t> : "θ"
    <Multi_key> <4> <e> : "€"
    <Multi_key> <4> <l> : "£"
    <Multi_key> <4> <y> : "¥"
    <Multi_key> <4> <r> : "₹"
    <Multi_key> <f> <h> : "🙂"
    <Multi_key> <f> <s> : "🙁"
    <Multi_key> <f> <d> : "😞"
    <Multi_key> <f> <a> : "😡"
    <Multi_key> <f> <w> : "😉"
    <Multi_key> <f> <c> : "🤪"
    <Multi_key> <f> <o> : "😳"
    <Multi_key> <f> <l> : "🥰"
    <Multi_key> <e> <f> : "🤦🏻"
    <Multi_key> <e> <s> : "🤷🏻"
    <Multi_key> <e> <t> <u> : "👍🏻"
    <Multi_key> <e> <t> <d> : "👎🏻"
    <Multi_key> <e> <p> : "👌🏻"
    <Multi_key> <e> <w> : "👋🏻"
    <Multi_key> <e> <h> : "🫶🏻"
    <Multi_key> <e> <l> : "❤️"
    <Multi_key> <e> <r> : "🚀"
    <Multi_key> <e> <c> : "☕"
    <Multi_key> <e> <z> : "⚡"
    <Multi_key> <t> <s> : "¯\_(ツ)_/¯"
    <Multi_key> <Up> <Up> : "↑"
    <Multi_key> <Down> <Down> : "↓"
    <Multi_key> <Left> <Left> : "←"
    <Multi_key> <Right> <Right> : "→"
    <Multi_key> <Left> <Right> : "↔"
    <Multi_key> <Right> <Left> : "↔"
    <Multi_key> <Up> <Down> : "↕"
    <Multi_key> <Down> <Up> : "↕"
    <Multi_key> <z> <Down> : "↯"
  '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    history.share = false;

    plugins = [ 
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "lein" "aws" "copypath" "copyfile" "copybuffer" "dirhistory" "fzf" ];
    };

    sessionVariables = {
      EDITOR = "nvim";
      GIT_EXTERNAL_DIFF = "difft";
    };

    localVariables = {
      COMPLETION_WAITING_DOTS = "true";
    };

    dirHashes = {
      docs  = "$HOME/Documents";
      vids  = "$HOME/Videos";
      dl    = "$HOME/Downloads";
      proj  = "$HOME/projects";
    };

    shellAliases = {
      l = "lsd -l";
      ll = "lsd -lA";
      m = "less -FnqRX";
      lstgz = "tar -tzvf";
      pi = "TERM=xterm ssh 192.168.2.10 -t \"tmux attach\"";
      lr = "lein repl";
      lf = "lein figwheel";
      nis = "nix-shell";
      nsp = "nix-shell -p";
      tan = "cd ~/projects/tantalus-cljs; nix-shell";
      pds = "cd ~/projects/pds-website; nix-shell";
      zoom-start = "NIXPKGS_ALLOW_UNFREE=1 nix-shell -p zoom-us --command 'zoom &'";
      cbcl = "xclip -sel c < /dev/null; xclip < /dev/null";
      cbp  = "xclip -o -sel c";
    };

    shellGlobalAliases = {
      cbcp = "xclip -sel c";
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
    userEmail = "##############";
    ignores = [ "rl-notes*" "*.swp" ];
    extraConfig = {
      init = {
        defaultBranch = "main";
        core.editor = "nvim";
        push.autoSetupRemote = true;
      };
    };

  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      nonylene.dark-molokai-theme
      dbaeumer.vscode-eslint
    ];
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
