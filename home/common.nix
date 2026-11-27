{ pkgs, config, ... }:
let
  localBin = "${config.home.homeDirectory}/.local/bin";
in
{
  home = {
    stateVersion = "26.05";

    packages = with pkgs; [
      nodejs_24
      pnpm
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    sessionPath = [
      "${../bin}"
      "${localBin}"
    ];

    file = {
      ".claude/CLAUDE.md".source = ../files/AGENTS.md;
      ".codex/AGENTS.md".source = ../files/AGENTS.md;
      ".config/AGENTS.md".source = ../files/AGENTS.md;
      ".config/herdr/config.toml".source = ../files/herdr/config.toml;
      ".config/tuicr/config.toml".source = ../files/tuicr/config.toml;
      ".pi/agent/AGENTS.md".source = ../files/AGENTS.md;
    };
  };

  imports = [
    ../programs/git.nix
    ../programs/neovim.nix
    ../programs/starship.nix
    ../programs/tmux.nix
    ../programs/zsh.nix
  ];

  programs = {
    home-manager = { enable = true; };

    fzf = {
      enable = true;
      defaultCommand = "fd --type file";
    };

    zoxide = { enable = true; };
    direnv = { enable = true; };
    mergiraf = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
