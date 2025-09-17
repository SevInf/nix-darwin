{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Serhii Tatarintsev";
    userEmail = "sergey@tatarintsev.me";
    difftastic.enable = true;
    aliases = {
      fpush = "push --force";
      amend = "commit -a --amend --no-edit";
      log-mine = "!sh -c 'git log --author \"$(git config --get user.name)\"'";
    };

    extraConfig = {
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      rebase.autostash = true;
      color.ui = true;
      merge.conflictstyle = "zdiff3";
      branch.autosetuprebase = "always";
      init.defaultBranch = "main";
      rerere.enabled = true;
      pull.rebase = true;
      diff.algorithm = "histogram";
      safe.directory = "${./..}";
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
