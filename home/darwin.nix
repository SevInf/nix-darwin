{ config, ... }:
let
  pnpmHome = "${config.home.homeDirectory}/Library/pnpm";
in
{
  imports = [
    ../programs/ghostty.nix
  ];

  home = {
    sessionVariables = {
      LSCOLORS = "Gxfxcxdxbxegedabagacad";
      CLICOLORS = "1";
      PNPM_HOME = pnpmHome;
    };

    shellAliases = { ls = "ls -G"; };

    sessionPath = [
      "/opt/homebrew/bin"
      "${pnpmHome}"
    ];

    file = {
      ".lima/_templates/dev-sandbox.yaml".source = ../files/lima/templates/dev-sandbox.yaml;
    };
  };

  programs.git.settings.user = {
    name = "Serhii Tatarintsev";
    email = "sergey@tatarintsev.me";
  };
}
