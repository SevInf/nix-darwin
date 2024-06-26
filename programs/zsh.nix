{ ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    initExtra = ''
      KEYTIMEOUT=5
      autoload -U colors
      zstyle ':completion:*' menu select
    '';
    syntaxHighlighting = { enable = true; };
    historySubstringSearch = { enable = true; };
  };
}
