{ gitProfile, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = gitProfile.name;
        email = gitProfile.email;
      };
      alias = {
        fpush = "push --force-with-lease";
        amend = "commit -a --amend --no-edit";
        log-mine = "!sh -c 'git log --author \"$(git config --get user.name)\"'";
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      rebase = {
        autostash = true;
        autosquash = true;
      };
      color.ui = true;
      merge.conflictstyle = "zdiff3";
      branch.autosetuprebase = "always";
      init.defaultBranch = "main";
      rerere.enabled = true;
      pull.rebase = true;
      diff.algorithm = "histogram";
      safe.directory = "${./..}";
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com";
        };
      };
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
