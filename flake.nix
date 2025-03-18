{
  description = "Mika's flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        mika = lib.nixosSystem {
          inherit system;
          modules = [
            ./modules/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        mika = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./modules/home.nix ];
        };
      };
    };
}
