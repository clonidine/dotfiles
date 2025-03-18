{ pkgs, ... }:

{
  imports = [
    ./waybar-settings.nix
    ./waybar-style.nix
  ];

  programs.waybar.enable = true;
}
