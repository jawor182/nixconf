# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  boot.kernelPackages = pkgs.linuxPackages_testing;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.nssmdns6 = true;
  # Power management
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "performance";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;
      START_CHARGE_THRESH_BAT0 = 20;
      STOP_CHARGE_THRESH_BAT0 = 80;
      START_CHARGE_THRESH_BAT1 = 50;
      STOP_CHARGE_THRESH_BAT1 = 80;

    };
  };


  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverridePackages = [ pkgs.mutter ];
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };

  environment.gnome.excludePackages = with pkgs; [
    evince
    epiphany
    geary
    loupe
    gnome-tour
    gnome-user-docs
    gnome-characters
    gnome-contacts
    gnome-font-viewer
    gnome-maps
    gnome-weather
    gnome-music
    gnome-connections
    simple-scan
    # gnome-software
    simple-scan
    snapshot
    totem
    yelp
    file-roller
    gnome-clocks
    seahorse
    gnome-calendar
    gnome-system-monitor
    eog
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jawor = {
    isNormalUser = true;
    description = "Jakub Jaworski";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      flatpak
      gnome-software
    ];
  };

  security.sudo = {
    enable = true;
    extraConfig = ''
      jawor ALL=(ALL) NOPASSWD: ALL
    '';
  };

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;
  # Services 
  # services.syncthing = {
  #   enable = true;
  # };
  services.xserver.excludePackages = [ pkgs.xterm ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    firefox
    neovim
    git
    ifuse
    libimobiledevice
    usbmuxd2
    usbmuxd
    stow
    zsh
    fish
    starship
    gnome-tweaks
    thunderbird
    ghostty
    alacritty
    brave
    obsidian
    discord
    spotify
    keepassxc
    vscode
    gh
    syncthing
    htop
    btop
    nerd-fonts.jetbrains-mono
    fzf
    tmux
    bat
    yazi
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
    gcc
    ntfs3g
    clang
    nodejs
    pnpm
    deno
    yarn
    ruby
    php
    python3
    go
    lua
    neofetch
    fastfetch
    rustup
    cargo
    unzip
    xclip
    wl-clipboard
    dconf-editor
    upower
    blueman
    networkmanager
    networkmanagerapplet
    todoist-electron
    catppuccin
    mission-center
    # home-manager
    cava
    # linuxKernel.kernels.linux_testing


    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.blur-my-shell


  ];
  
  # Kernel
  # boot.kernelPackages = pkgs.linuxKernel.kernels.linux_testing;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.usbmuxd = {
    enable = true;
  };
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # ENVS
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  home-manager.backupFileExtension = "backup";
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
