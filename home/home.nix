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
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      v = "vim";
      nixv = "cd ~/nixos; vim";
      nix-update = "cd ~/nixos; just rebuild";
      nix-upgrade = "cd ~/nixos; just commit; just update commit";
    };

    history.size = 10000;
    history.ignoreAllDups = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
      ];
      theme = "robbyrussell";
    };

    initContent = ''
      # Load version control information
      autoload -Uz vcs_info
      precmd() { vcs_info }

      # Format the vcs_info_msg_0_ variable
      zstyle ':vcs_info:git:*' formats '%b'

      # Set up the prompt (with git branch name)
      setopt PROMPT_SUBST

      PROMPT='%F{gray}%~%f %F{red}''${vcs_info_msg_0_}%f$ '
    '';
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
    FZF_DEFAULT_OPTS = "--color=fg:-1,bg:-1,hl:#af0000,fg+:#d0d0d0,bg+:#000000,hl+:#ff0000,info:#ff0000,prompt:#ff0000,pointer:#ff0000,marker:#af0000,spinner:#eeeeee,header:#bcbcbc";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
