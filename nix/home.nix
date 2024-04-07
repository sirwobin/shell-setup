{ config, pkgs, lib, ... }:
let
  fontConf = {
    names = [ "FiraCode Nerd Font Mono" ];
    size = 18.0;
  };
in
{
  home.username = "robin";
  home.homeDirectory = "/home/robin";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [ neovim lsd fzf btop powerline-go zsh-autosuggestions tree which pulseaudioFull
                               kitty firefox chromium bitwarden bitwarden-cli gscan2pdf tesseract5
                               libreoffice encfs vlc mplayer ranger nomacs difftastic wl-clipboard
  ];

  programs.swaylock.enable = true;
  services.kanshi.enable = true;
  services.mako.enable = true;

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock"; }
      { event = "after-resume"; command = "swaymsg \"output\" * dpms on"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock"; }
      { timeout = 600; command = "swaymsg \"output\" * dpms off"; }
    ];
  };

  programs.i3status = {
    enable = true;

    general = {
      output_format = "i3bar";
      colors = true;
      interval = 10;
#      color_good = "#${colorscheme.dark.green}";
#      color_degraded = "#${colorscheme.dark.orange}";
#      color_bad = "#${colorscheme.dark.red}";
    };

    modules = {
      load = {
        position = 0;
        settings.format = "load: %1min, %5min, %15min ";
      };
      memory = {
        position = 1;
        settings.format = " MEM %free (%used) ";
        settings.threshold_degraded = "10%";
        settings.format_degraded = " LOW %free ";
      };
      "battery all" = {
        position = 2;
        settings.format = "%status %percentage %remaining %emptytime";
        settings.format_down = "No battery";
        settings.status_chr = "⚡ ";
        settings.status_bat = "🔋 ";
        settings.status_unk = "? ";
        settings.status_full = "☻ ";
        settings.path = "/sys/class/power_supply/BAT%d/uevent";
        settings.low_threshold = "10";
      };
      "volume master" = {
        position = 3;
        settings.format = " 🔊 %volume ";
        settings.format_muted = " 🔇 ";
        settings.device = "default";
      };
      time = {
        position = 4;
        settings.format = " %Y-%m-%d %H:%M";
      };
      ipv6.enable = false;
      "wireless _first_".enable = false;
      "ethernet _first_".enable = false;
      "tztime local".enable = false;
      "disk /".enable = false;
    };
  };

  programs.fuzzel = {
    enable = true;
    settings.main.font = "FiraCode Nerd Font Mono:size=25";
  };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          repeat_delay = "200";
          repeat_rate = "25";
        };
      };
      output = {
        "eDP-1" = {
          mode = "3200x1800";
          pos = "800 2160";
          scale = "1.5";
        };
        "HDMI-A-2" = {
          mode = "3840x2160";
          pos = "0 0";
        };
      };

      fonts = fontConf;

      window = {
        titlebar = true;
        border = 2;
      };

      workspaceOutputAssign = [
        { workspace = "1"; output = "eDP-1"; }
        { workspace = "2"; output = "eDP-1"; }
        { workspace = "3"; output = "eDP-1"; }
        { workspace = "4"; output = "eDP-1"; }
        { workspace = "5"; output = "eDP-1"; }
        { workspace = "6"; output = "HDMI-A-2"; }
        { workspace = "7"; output = "HDMI-A-2"; }
        { workspace = "8"; output = "HDMI-A-2"; }
        { workspace = "9"; output = "HDMI-A-2"; }
        { workspace = "10"; output = "HDMI-A-2"; }
      ];

      bars = lib.singleton {
        statusCommand = lib.getExe pkgs.i3status;
        command = lib.getExe' pkgs.sway "swaybar";
        position = "bottom";
        fonts = fontConf;
        trayOutput = "*";
      };

      menu = lib.getExe pkgs.fuzzel;

      startup = [
        { command = "mako"; }
        { command = "swayidle"; }
      ];

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          inherit (config.wayland.windowManager.sway.config)
            menu
            terminal
            ;
        in
        {
          "${mod}+Return" = "exec ${terminal}";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec ${menu}";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

#          "${mod}+p" = "exec ${lib.getExe pkgs.slurp} | ${lib.getExe pkgs.grim} -g- screenshot-$(date +%Y%m%d-%H%M%S).png";

#          "${mod}+h" = "split h";
#          "${mod}+v" = "split v";
          "${mod}+z" = "fullscreen toggle";
          "${mod}+comma" = "layout stacking";
          "${mod}+period" = "layout tabbed";
          "${mod}+slash" = "layout toggle split";
          "${mod}+a" = "focus parent";
          "${mod}+s" = "focus child";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";
          "${mod}+Shift+v" = ''mode "system:  [r]eboot  [p]oweroff  [l]ogout"'';

          "${mod}+r" = "mode resize";

          "${mod}+l" = "exec ${pkgs.swaylock}/bin/swaylock";
          "${mod}+k" = "exec ${lib.getExe' pkgs.mako "makoctl"} dismiss";
          "${mod}+Shift+k" = "exec ${lib.getExe' pkgs.mako "makoctl"} dismiss -a";

          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.light} -A 10";
          "XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.light} -U 10";

          "${mod}+apostrophe" = "move workspace to output right";

          "${mod}+minus" = "scratchpad show";
          "${mod}+underscore" = "move container to scratchpad";
        };
    };
  };

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
      cbcl = "wl-copy < /dev/null";
      cbp  = "wl-paste";
    };

    shellGlobalAliases = {
      cbcp = "wl-copy";
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
