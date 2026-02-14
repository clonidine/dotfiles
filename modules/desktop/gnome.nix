{
  pkgs,
  lib,
  home-manager,
  ...
}:
let
  inherit (lib.hm.gvariant) mkTuple;
in
{
  home.packages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.dash-to-dock
    gnome-system-monitor
    gnome-screenshot
    gnomeExtensions.screenshort-cut
    nautilus
    loupe
  ];

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [
        (mkTuple [
          "xkb"
          "us+intl"
        ])
      ];
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [
        "kitty.desktop"
        "zen.desktop"
        "codium.desktop"
        "org.gnome.Nautilus.desktop"
        "vesktop.desktop"
        "spotify.desktop"
      ];
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
      ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      multi-monitor = true;
      dock-position = "BOTTOM";

      autohide = true;
      intellihide = true;
      dock-fixed = false;

      show-mounts = false;
      click-action = "cycle-windows";

      extend-height = false;
      dash-max-icon-size = 52;
      background-opacity = 0.2;
      custom-background-color = false;
      background-color = "rgb(0,0,0)";
      custom-theme-shrink = false;
    };
  };
}
