{ pkgs, ... }:

{
  imports = [
    ./themes/midnight-haze.nix
    ./font.nix
  ];

  programs.alacritty.enable = true;
}
