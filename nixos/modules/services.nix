{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the ly as the Display Manager
  services.displayManager.ly.enable = true;

  # Enable the Mullvad VPN
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = false;
}
