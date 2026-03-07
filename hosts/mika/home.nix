{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "mika";
  home.homeDirectory = "/home/mika";

  home.stateVersion = "23.11";

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  imports = [
    ./home-packages.nix
    ./modules-imports.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
