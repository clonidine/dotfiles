{
  lib,
  ...
}:

{
  home.username = "mika";
  home.homeDirectory = "/home/mika";

  home.stateVersion = "25.05";

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

  programs.zsh.shellAliases = {
    hrbd = lib.mkForce "home-manager switch --flake ~/dotfiles#mika@wsl";
    rbd = lib.mkForce "sudo nixos-rebuild switch --flake ~/dotfiles#mika-wsl";
  };
}
