{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./zsh.nix
    ./yazi.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "andre";
  home.homeDirectory = "/home/andre";

  home.stateVersion = "25.05";

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/music";

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipewireOutput"
      }
    '';
  };

  home.packages = with pkgs; [
    # Utilities
    wget file fzf ripgrep clipse btop tmux bluetui fd zoxide eza bat unrar dust
    _7zz-rar

    # Less useful utilities
    neocities kdePackages.dolphin nwg-look solaar qbittorrent limo zenity bottles gitui libreoffice-qt6-fresh

    # Wayland
    wl-clipboard

    # Fun Stuff
    cowsay fastfetch wiki-tui fortune cmatrix asciiquarium-transparent

    # Gaming
    lutris dsda-doom gamescope mangohud mangohud nethack dolphin-emu prismlauncher heroic

    # Messaging
    vesktop discord wasistlos whatsie

    # Note taking
    obsidian

    # Video
    vlc

    # Music
    rmpc ncmpcpp mpc

    # Imaging
    gimp grim slurp timg imagemagick
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
    TERMINAL = "kitty";
    TERM = "kitty";
    FZF_DEFAULT_OPTS = "--color=fg:-1,bg:-1,hl:#af0000,fg+:#d0d0d0,bg+:#000000,hl+:#ff0000,info:#ff0000,prompt:#ff0000,pointer:#ff0000,marker:#af0000,spinner:#eeeeee,header:#bcbcbc";
    GRIM_DEFAULT_DIR = "screenshots";
  };

  programs.home-manager.enable = true;
}
