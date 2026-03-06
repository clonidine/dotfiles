{ pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  users.users.mika = {
    home = "/Users/mika";
    shell = pkgs.zsh;
  };

  environment.shells = [ pkgs.zsh ];
  programs.zsh.enable = true;

  system.primaryUser = "mika";
  system.stateVersion = 6;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
  };
  home-manager.users.mika = import ./home.nix;
}
