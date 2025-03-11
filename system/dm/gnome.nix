{ pkgs, home-manager, ... }:

{
  home.packages = with pkgs; [ gnomeExtensions.dash-to-dock ];
}
