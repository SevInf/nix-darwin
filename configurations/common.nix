{ pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    fzf
    gh
    python3
    rustup
    htop
    wget
    jq
    tmux
    fd
    bat
    eza
    ripgrep
    unstable.lima
    nixpkgs-fmt
    nil
  ];


  nix.enable = false;
  nix.package = pkgs.nix;

  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;



  fonts.packages = [
    pkgs.fira-code
    pkgs.nerd-fonts.fira-code
  ];

  environment = {
    shells = [ pkgs.zsh ];
  };

  users.users.sevinf = {
    name = "sevinf";
    home = "/Users/sevinf";
    description = "Serhii Tatarintsev";
    shell = pkgs.zsh;
  };

}
