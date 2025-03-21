{ pkgs, ... }:

let
  isHyprland = builtins.getEnv "XDG_SESSION_DESKTOP" == "Hyprland";
in
{
  services.flameshot.enable = !isHyprland;
}
