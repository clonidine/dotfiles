{
  description = "Mika's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lunar-client = {
      url = "github:clonidine/lunar-client-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      agenix,
      spicetify-nix,
      lunar-client,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems =
        f:
        builtins.listToAttrs (
          map (system: {
            name = system;
            value = f system;
          }) systems
        );

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      mkNixos =
        host: system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/${host}/configuration.nix
            agenix.nixosModules.default
          ];
          specialArgs = {
            inherit spicetify-nix inputs;
          };
        };

      mkHome =
        host: system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          modules = [
            ./hosts/${host}/home.nix
            agenix.homeManagerModules.default
          ];
          extraSpecialArgs = {
            inherit spicetify-nix inputs;
          };
        };

      mkDarwin =
        host: system:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./hosts/${host}/darwin.nix
            home-manager.darwinModules.home-manager
          ];
          specialArgs = {
            inherit spicetify-nix inputs;
          };
        };

    in
    {
      nixosConfigurations = {
        mika = mkNixos "mika" "x86_64-linux";
      };

      darwinConfigurations = {
        mika-macbook = mkDarwin "mika-macbook" "aarch64-darwin";
      };

      homeConfigurations = {
        mika = mkHome "mika" "x86_64-linux";
        "mika@macbook" = mkHome "mika-macbook" "aarch64-darwin";
      };

      packages = forAllSystems (
        system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.hello;
          agenix = agenix.packages.${system}.default;
        }
      );
    };
}
