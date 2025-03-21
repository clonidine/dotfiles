{ pkgs, ... }:

{
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      modules-left = [
        "sway/workspaces"
        "sway/mode"
      ];
      modules-center = [ "sway/window" ];
      modules-right = [
        "clock"
      ];
      "sway/window" = {
        max-length = 50;
      };
      "clock" = {
        format-alt = "{:%a, %d. %b  %H:%M}";
      };
    };
  };
}
