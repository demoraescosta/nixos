{ config, pkgs, ... }:

{
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

    # home.packages = [
    #     (pkgs.buildEnv { 
    #         name = "scripts";
    #         paths = [
    #             ./scripts;
    #         ];
    #     })
    # ];

# The home.packages option allows you to install Nix packages into your
# environment.
    home.packages = with pkgs; [
        (pkgs.buildEnv { 
            name = "my-scripts"; 
            paths = [ 
                ./scripts 
            ]; 
        })
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
    ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
    home.file = {
        ".config/rofi/" = { 
            recursive = true;
            source = dotfiles/rofi;
        };
    };

# Home Manager can also manage your environment variables through
# 'home.sessionVariables'. These will be explicitly sourced when using a
# shell provided by Home Manager. If you don't want to manage your shell
# through Home Manager then you have to manually source 'hm-session-vars.sh'
# located at either
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/andre/etc/profile.d/hm-session-vars.sh
#
    home.sessionVariables = {
        EDITOR = "vim";
        VISUAL = "vim";
        HYPRSHOT_DIR = "~/screenshots";
        TERMINAL = "kitty";
        TERM = "kitty";
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
