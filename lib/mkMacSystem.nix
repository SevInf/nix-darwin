{ inputs }:

{ system }:

inputs.nix-darwin.lib.darwinSystem {
  inherit system;
  modules = [
    ../configuration.nix
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.sevinf = import ../home.nix;
      };
    }
  ];
  specialArgs = { inherit inputs; };
}
