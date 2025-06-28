{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "exa";
      ll = "exa -la";
      v = "vim";
      y = "yazi";
      cat = "bat";

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
      theme = "simple";
    };

    initContent = ''
      eval "$(zoxide init zsh)"

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
}
