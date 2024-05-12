{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Serhii Tatarintsev";
    userEmail = "sergey@tatarintsev.me";
    difftastic.enable = true;
    aliases = {
      amend = "commit -a --amend --no-edit";
      log-mine = "!sh -c 'git log --author \"$(git config --get user.name)\"'";
    };

    extraConfig = {
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      color.ui = true;
      merge.conflictstyle = "zdiff3";
      branch.autosetuprebase = "always";
      init.defaultBranch = "main";
      rerere.enabled = true;
      pull.rebase = true;
      diff.algorithm = "histogram";
    };
    ignores = [
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      "Icon"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      ".*.s[a-w][a-z]"
      "*.un~"
      "Session.vim"
      ".netrwhist"
      "*~"
      ".idea"
      ".lvimrc"
      "*.code-workspace"
    ];
  };
}
