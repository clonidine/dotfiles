{ pkgs, ... }:

let
  hyprConfigPath = ".config/hypr";
  hyprConfigFiles = [
    "hyprland.conf"
    "keybinding.conf"
    "monitor.conf"
    "window.conf"
    "workspace.conf"
    "volume_control.conf"
    "scripts/volume_control.sh"
  ];
in
{
  programs.kitty.enable = true; # required for the default Hyprland config

  home.packages = [ pkgs.waybar ];
  # wayland.windowManager.hyprland.enable = true; # enable Hyprland

  # Optional, hint Electron apps to use Wayland:
  # home.sessionVariables.NIXOS_OZONE_WL = "1";
  home.file = builtins.listToAttrs (
    map (fileName: {
      name = "${hyprConfigPath}/${fileName}";
      value = {
        source = ../../dotfiles/hypr/${fileName};
      };
    }) hyprConfigFiles
  );
}
