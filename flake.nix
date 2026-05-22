{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-lima.url = "github:nixos-lima/nixos-lima/master";
    nixos-lima.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager, nixos-lima }:
    {
      darwinConfigurations.home = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./configurations/common.nix
          ./configurations/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.sevinf = import ./home.nix;
            };
          }
        ];
        specialArgs = {
          inherit inputs;
          unstable = import nixpkgs-unstable {
            system = "aarch64-darwin";
          };
        };
      };

      nixosConfigurations.sandbox = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          nixos-lima.nixosModules.lima
          ./configurations/common.nix
          ./configurations/sandbox.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.sevinf = ./home.nix;
            };
          }
        ];

        specialArgs = {
          inherit inputs;
          unstable = import nixpkgs-unstable {
            system = "aarch64-linux";
          };
        };
      };
    };
}
