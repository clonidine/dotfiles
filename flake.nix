{
  description = "Mika's flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      spicetify-nix,
      ...
    }@inputs:
    let
      # ------------------------------
      #  Supported systems
      # ------------------------------
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
          ];
          extraSpecialArgs = {
            inherit spicetify-nix;
          };
        };

    in
    {
      # ------------------------------
      #  NixOS HOSTS
      # ------------------------------
      nixosConfigurations = {
        mika = mkNixos "mika" "x86_64-linux";
        # desktop1 = mkNixos "desktop1" "x86_64-linux";
        # rpi = mkNixos "rpi" "aarch64-linux";
      };

      # ------------------------------
      #  Home Manager configs
      # ------------------------------
      homeConfigurations = {
        mika = mkHome "mika" "x86_64-linux";
        # work-laptop = mkHome "work-laptop" "x86_64-linux";
      };

      packages = forAllSystems (
        system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.hello;
        }
      );
    };
}
