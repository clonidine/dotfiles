{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      arch = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = lib.nixosSystem {
        system = arch;
        modules = [
          ./host/configuration.nix
        ];
      };
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      homeConfigurations = {
        "mig" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = arch; };

          modules = [ ./pkgs ];
        };
      };
      programs.home-manager.enable = true;
    };
}
