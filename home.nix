{ pkgs, ... }:
let
  username = "sevinf";
  homeDirectory = "/Users/${username}";
  pnpmHome = "${homeDirectory}/Library/pnpm";
in
{
  home = {
    inherit username homeDirectory;
    stateVersion = "23.11";

    packages = with pkgs; [
      nodejs
      pnpm
    ];

    sessionVariables = {
      EDITOR = "nvim";
      LSCOLORS = "Gxfxcxdxbxegedabagacad";
      LS_COLORS =
        "di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43";
      CLICOLORS = "1";
      PNPM_HOME = pnpmHome;
    };

    shellAliases = { ls = "ls -G"; };

    sessionPath = [
      "${./bin}"
      "/opt/homebrew/bin"
      "${pnpmHome}"
    ];
  };

  imports = [
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/starship.nix
    ./programs/tmux.nix
    ./programs/zsh.nix
    ./programs/ghostty.nix
  ];

  programs = {
    home-manager = { enable = true; };

    fzf = {
      enable = true;
      defaultCommand = "fd --type file";
    };

    zoxide = { enable = true; };
    direnv = { enable = true; };
  };
}
