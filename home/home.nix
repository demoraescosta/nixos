{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andre";
  home.homeDirectory = "/home/andre";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    wget
    fastfetch
    lutris
    vesktop
    discord
    obsidian
    ripgrep
    fzf
    hyprshot
    tmux
    btop
    gamescope
    imagemagick
    qbittorrent
    neovim
    whatsie
    mangohud
    yazi
    bluetui
    dolphin-emu
    prismlauncher
    heroic
    kdePackages.dolphin
    nwg-look
    rustup
    vlc
    clipse
    dsda-doom
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting = true;

    shellAliases = {
      ll = "ls -la";
      v = "vim";
      nixv = "cd ~/nixos; vim";
      nix-update = "cd ~/nixos; just rebuild";
      nix-upgrade = "cd ~/nixos; just commit update commit";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
  };

  home.file = {
    "bin/" = {
      source = ./scripts/bin;
      recursive = true;
    };
  };
  home.sessionPath = ["/home/andre/bin"];

  #  /etc/profiles/per-user/andre/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    HYPRSHOT_DIR = "screenshots";
    TERMINAL = "kitty";
    TERM = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
