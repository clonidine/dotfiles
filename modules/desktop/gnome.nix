{ pkgs, home-manager, ... }:

{
  home.packages = with pkgs; [ gnomeExtensions.dash-to-dock gnome-system-monitor gnome-screenshot gnomeExtensions.screenshort-cut gnome-tweaks ];
}
