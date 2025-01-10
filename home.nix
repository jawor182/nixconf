{ config, pkgs, programs, ... }:

{
  home.username = "jawor";
  home.homeDirectory = "/home/jawor";
  home.packages = with pkgs; [

    zip
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
    pciutils # lspci
    usbutils # lsusb
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect
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
        ];
      };
      # Extensions 
      "org/gnome/shell/extensions/blur-my-shell" = {
        brightness = 1;
        noise-amount = 0;
      };
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
        move-to-workspace-1 = [ "<Shift><Super>1"];
        move-to-workspace-2 = [ "<Shift><Super>2"];
        move-to-workspace-3 = [ "<Shift><Super>3"];
        move-to-workspace-4 = [ "<Shift><Super>4"];
        move-to-workspace-5 = [ "<Shift><Super>5"];
        move-to-workspace-6 = [ "<Shift><Super>6"];
        move-to-workspace-7 = [ "<Shift><Super>7"];
        move-to-workspace-8 = [ "<Shift><Super>8"];
        move-to-workspace-9 = [ "<Shift><Super>9"];
        move-to-workspace-10 = [ "<Shift><Super>0"];

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

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
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
      rm = "rm -rf";
      gst = "git status";
      gcm = "git commit -m";
      gps = "git push";
      gad = "git add";
      lshw = "sudo lshw";
      zb = "zbarimg";
      zshupdate = "source ~/.zshrc";
      nixupdate = "sudo nixos-rebuild switch --flake ~/nixconf#nixos";

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
