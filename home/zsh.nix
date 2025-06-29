{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "exa --group-directories-first";
      l = "exa -l --sort=extension";
      ll = "exa -la --sort=extension";
      v = "vim";
      cat = "bat";
      wttr = "curl wttr.in/rio";

      nixv = "cd ~/nixos; vim";
      nixrb = "sudo nixos-rebuild switch";
      nixrbu = "sudo nixos-rebuild switch --upgrade";
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
      function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            yazi "$@" --cwd-file="$tmp"
            IFS= read -r -d ''' cwd < "$tmp"
            [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
            rm -f -- "$tmp"
      }

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
