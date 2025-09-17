{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:

    let
      mkMacSystem = import ./lib/mkMacSystem.nix {
        inherit inputs;
      };
    in
    {
      darwinConfigurations.mac-intel = mkMacSystem {
        system = "x86_64-darwin";
      };

      darwinConfigurations.mac-arm = mkMacSystem {
        system = "aarch64-darwin";
      };

    };
}
