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

# The home.packages option allows you to install Nix packages into your
# environment.
        home.packages = with pkgs; [
            gh
            wget
            fastfetch
            lutris
            vesktop
            discord
            obsidian
            kitty
            ripgrep
            fzf
            kdePackages.dolphin
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
        ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
    home.file = {
# # Building this configuration will create a copy of 'dotfiles/screenrc' in
# # the Nix store. Activating the configuration will then make '~/.screenrc' a
# # symlink to the Nix store copy.
# ".screenrc".source = dotfiles/screenrc;
    # "./config/hypr/hyprland.conf" = {
    #     source = config.lib.file.mkOutOfStoreSymLink /home/andre/nixos/home/dotfiles/hypr/ 
    #     recursive = true;
    # };
      
# # You can also set the file content immediately.
# ".gradle/gradle.properties".text = ''
#   org.gradle.console=verbose
#   org.gradle.daemon.idletimeout=3600000
# '';
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
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
