{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./zsh.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.stateVersion = "25.05";

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
    solaar
    nethack
    cowsay
    rmpc
  ];

  home.file = {
    "bin/" = {
      source = ./scripts/bin;
      recursive = true;
    };
  };
  home.sessionPath = ["/home/andre/bin"];

  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    HYPRSHOT_DIR = "screenshots";
    TERMINAL = "kitty";
    TERM = "kitty";
    FZF_DEFAULT_OPTS = "--color=fg:-1,bg:-1,hl:#af0000,fg+:#d0d0d0,bg+:#000000,hl+:#ff0000,info:#ff0000,prompt:#ff0000,pointer:#ff0000,marker:#af0000,spinner:#eeeeee,header:#bcbcbc";
  };

  programs.home-manager.enable = true;
}
