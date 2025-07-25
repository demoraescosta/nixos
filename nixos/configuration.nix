# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nh.nix
    inputs.home-manager.nixosModules.default
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # enable GCC to USB adapter overclocking
  boot.extraModulePackages = [
    config.boot.kernelPackages.gcadapter-oc-kmod
  ];

  # to autoload at boot:
  boot.kernelModules = [
    "gcadapter_oc"
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = ["nix-command" "flakes"];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "ibus";

  };

  # fix framdedrops on hyprland because of mesa version mismatch
  hardware.graphics = {
    package = pkgs-unstable.mesa;

    enable32Bit = true;
    package32 = pkgs-unstable.pkgsi686Linux.mesa;
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];

  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "andre";

  # services.desktopManager.plasma6.enable = true;
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "andre" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "nativo";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # enable gamecube controllers
  services.udev.packages = [pkgs.dolphin-emu];

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
  users.users.andre = {
    isNormalUser = true;
    description = "Andre de Moraes Costa";
    extraGroups = ["networkmanager" "wheel" "video"];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  services.flatpak.enable = true;

  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   users = {
  #     "andre" = import /home.nix;
  #   };
  # };

  qt = {
    enable = true;
    style = "adwaita-dark";
  };

  # Enable automatic login for the user.

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    just

    git
    kitty
    gh
    firefox
    spotify
    nixfmt-rfc-style
    pipx
    python313Packages.pip
    inotify-tools

    wineWowPackages.stable
    winetricks
    protontricks

    ly
    waybar
    dunst
    libnotify
    swww
    rofi-wayland

    xdg-desktop-portal-termfilechooser
    playerctl
    openrgb-with-all-plugins
  ];

  fonts = {
    packages = let
      apple = inputs.apple-fonts.packages.${pkgs.system};
    in
      with pkgs; [
        dina-font
        fairfax
        fira-code
        roboto
        nasin-nanpa

        apple.sf-pro
        apple.sf-mono
      ];

    fontconfig = {
      antialias = true;
      subpixel.rgba = "none";
      cache32Bit = true;
      hinting.enable = true;
      hinting.autohint = true;

      defaultFonts = {
        sansSerif = [
          "Noto Sans"
        ];
        monospace = [
          "Fira Code"
        ];
      };
    };
  };

  services.hardware.openrgb.enable = true;

  # programs.vim.enable = true;
  # programs.vim.defaultEditor = true;

  programs.vim = {
    enable = true;
    defaultEditor = true;
    # package = pkgs.vim-full;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          libkrb5
          keyutils
        ];
    };
  };

  programs.gamemode.enable = true;
  programs.nix-ld.enable = true;

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.andre.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  };
  environment.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    TERMINAL = "kitty";
    TERM = "kitty";
  };

  xdg.mime.defaultApplications = {
    "x-scheme-handler/terminal" = "kitty.desktop";
    "application/pdf" = "firefox.desktop";
    "inode/directory" = "yazi.desktop";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [57621];
  networking.firewall.allowedUDPPorts = [5353];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--upgrade-input"
      "nixpkgs"
      "L"
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
