{ config, pkgs, programs, ... }:

{
  home.username = "jawor";
  home.homeDirectory = "/home/jawor";
  home.packages = with pkgs; [


    zip
    bat
    solaar
    busybox
    pulsemixer
    acpi
    cava
    xz
    unzip
    p7zip
    ripgrep
    jq
    fzf
    nix-output-monitor
    iotop
    iftop
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    lshw
    pciutils # lspci
    usbutils # lsusb 
    zbar
    tree
    tlp
    zathura
    catppuccin
    powertop
    # Gnome extensions
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect
    # gnomeExtensions.thinkpad-battery-threshold
    gnomeExtensions.caffeine
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          pkgs.gnomeExtensions.blur-my-shell.extensionUuid
          pkgs.gnomeExtensions.dash-to-dock.extensionUuid
          pkgs.gnomeExtensions.gsconnect.extensionUuid
          # pkgs.gnomeExtensions.thinkpad-battery-threshold.extensionUuid
          pkgs.gnomeExtensions.caffeine.extensionUuid
        ];
      };
      # Extensions 
      "org/gnome/shell/extensions/blur-my-shell" = {
        brightness = 1;
        noise-amount = 0;
      };
      #   "org/gnome/shell/extensions/thinkpad-battery-threshold" = {
      #   start-bat0 = 50;
      #   end-bat0 = 100;
      #   start-bat1 = 50;
      #   end-bat1 = 100;
      # };
      "org/gnome/shell/extensions/dash-to-dock" = {
        # Add settings for dash-to-dock if needed
        running-indicator-style = "DOTS";
        hot-keys = false;
        show-trash = false;

      };
      "org/gnome/mutter" = {
        "experimental-features" = "['scale-monitor-framebuffer']";
      };
      # Keybinds
      "org/gnome/desktop/wm/keybindings" = {
        # Moving to the workspace
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];
        switch-to-workspace-10 = [ "<Super>0" ];

        # Moving WINDOW to the workspace 
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        move-to-workspace-5 = [ "<Shift><Super>5" ];
        move-to-workspace-6 = [ "<Shift><Super>6" ];
        move-to-workspace-7 = [ "<Shift><Super>7" ];
        move-to-workspace-8 = [ "<Shift><Super>8" ];
        move-to-workspace-9 = [ "<Shift><Super>9" ];
        move-to-workspace-10 = [ "<Shift><Super>0" ];

        maximize = [ "<Super>F" ];
        close = [ "<Super>Q" ];
      };
      # Disable running apps from dock
      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ " " ];
        switch-to-application-2 = [ " " ];
        switch-to-application-3 = [ " " ];
        switch-to-application-4 = [ " " ];
        switch-to-application-5 = [ " " ];
        switch-to-application-6 = [ " " ];
        switch-to-application-7 = [ " " ];
        switch-to-application-8 = [ " " ];
        switch-to-application-9 = [ " " ];
        switch-to-application-10 = [ " " ];
      };
      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 10;
      };
    };
  };
  catppuccin = {
    # enable = true;
    flavor = "mocha";
    yazi.enable = true;
    bat.enable = false;
    btop.enable = true;
    fzf.enable = true;
    cava.enable = true;
    cava.transparent = true;
    ghostty.enable = true;
    alacritty.enable = true;
    zathura.enable = true;
    zsh-syntax-highlighting.enable = true;
    tmux.enable = true;
    tmux.extraConfig = "";
  };
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
      autoload -U colors && colors  # Load colors
      export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
      setopt autocd
      HISTSIZE=10000000
      SAVEHIST=10000000
      HISTFILE="$HOME/.zsh_history"
      setopt share_history
      setopt inc_append_history
      # Basic auto/tab complete:
      autoload -U compinit
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots)# Include hidden files.
      autoload -U zsh-autosuggestions
      # zmodload zsh/autosuggestions
      # vi mode
      bindkey -v
      export KEYTIMEOUT=1

      # Use vim keys in tab complete menu:
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey -v '^?' backward-delete-char

      # Change cursor shape for different vi modes.
      function zle-keymap-select () {
          case $KEYMAP in
              vicmd) echo -ne '\e[1 q';;      # block
              viins|main) echo -ne '\e[5 q';; # beam
          esac
      }
      zle -N zle-keymap-select
      zle-line-init() {
          zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
          echo -ne "\e[5 q"
      }
      zle -N zle-line-init
      echo -ne '\e[5 q' # Use beam shape cursor on startup.
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


      # Edit line in vim with ctrl-e:
      autoload edit-command-line; zle -N edit-command-line
      bindkey '^e' edit-command-line
      bindkey -M vicmd '^[[P' vi-delete-char
      bindkey -M vicmd '^e' edit-command-line
      bindkey -M visual '^[[P' vi-delete
    '';
    shellAliases = {
      n = "nvim";
      b = "btop";
      t = "tmux";
      h = "htop";
      y = "yazi";
      dev = "npm run dev";
      ls = "ls --color";
      la = "ls -la";
      ll = "ls -l";
      lah = "ls -lah";
      rm = "rm -rf";
      gst = "git status";
      gcm = "git commit -m";
      gps = "git push";
      gad = "git add";
      lshw = "sudo lshw";
      zb = "zbarimg";
      SS = "sudo systemctl";
      zshupdate = "source ~/.zshrc";
      nixupdate = "sudo nixos-rebuild switch --flake ~/nixconf#nixos";
      ff = "fastfetch";
      # hms = "home-manager -f ~/nixconf/home.nix switch --flake ~/nixconf#nixos";

    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 16;
      };
      window = {
        opacity = 0.75;
      };
    };
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "screen-256color";
    sensibleOnTop = true;
    clock24 = true;
    keyMode = "vi";
    prefix = "C-s";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.yank;
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
      # {
      #   plugin = tmuxPlugins.gruvbox;
      #   extraConfig = "set -g @tmux-gruvbox 'dark'";
      # }
      
    ];
    extraConfig = "
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind 'v' split-window -v -c '#{pane_current_path}'
      bind 'h' split-window -h -c '#{pane_current_path}'
      bind C-l send-keys 'C-l'
      bind -n M-H previous-window
      bind -n M-L next-window
      ";
  };

  programs.btop = {
    enable = true;
    settings = {
      # color_theme = "gruvbox_dark_v2";
      theme_background = "true";
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    # flavors = {
    #   dark = "package.gruvbox-dark";
    # };
    settings = {
      manager = {
        show_hidden = true;
      };
    };
  };
  programs.git = {
    enable = true;
    userName = "jawor182";
    userEmail = "kubajaworski59@outlook.com";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  home.enableNixpkgsReleaseCheck = false;
}
