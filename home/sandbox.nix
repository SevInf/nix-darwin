{ config, ... }:
let
  pnpmHome = "${config.home.homeDirectory}/.local/share/pnpm";
in
{
  home = {
    sessionVariables = {
      LS_COLORS =
        "di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43";
      PNPM_HOME = pnpmHome;
    };

    shellAliases = { ls = "ls --color=auto"; };

    sessionPath = [
      "${pnpmHome}"
    ];
  };

  programs.git.settings.user = {
    name = "Steven McClankerton";
    email = "tatarintsev+clanker@prisma.io";
  };
}
