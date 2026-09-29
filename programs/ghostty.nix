{ ... }:

{
  programs.ghostty = {
    enable = true;
    systemd.enable = false;
    package = null;
    enableZshIntegration = true;
    settings = {
      theme = "One Half Dark";
      font-family = "Fira Code Nerd Font Mono";
      font-size = 16;
    };
  };
}
