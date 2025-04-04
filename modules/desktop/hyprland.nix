{ pkgs, ... }:

{
  programs.kitty.enable = true; # required for the default Hyprland config

  home.packages = with pkgs; [
    # Misc
    hyprpaper
    hyprlock
    hyprshot

    # Plugins
    hyprlandPlugins.hyprbars
  ];

  xdg.configFile = {
    "hypr/hyprland.conf".source = ../../dotfiles/hypr/hyprland.conf;
    "hypr/keybinding.conf".source = ../../dotfiles/hypr/keybinding.conf;
    "hypr/monitor.conf".source = ../../dotfiles/hypr/monitor.conf;
    "hypr/window.conf".source = ../../dotfiles/hypr/window.conf;
    "hypr/workspace.conf".source = ../../dotfiles/hypr/workspace.conf;
    "hypr/volume_control.conf".source = ../../dotfiles/hypr/volume_control.conf;
    "hypr/hyprpaper.conf".source = ../../dotfiles/hypr/hyprpaper.conf;
    "hypr/hyprlock.conf".source = ../../dotfiles/hypr/hyprlock.conf;
    "hypr/colors.conf".source = ../../dotfiles/hypr/colors.conf;
    "hypr/scripts/wall_randomizer" = {
      source = ../../dotfiles/hypr/scripts/wall_randomizer;
      executable = true;
    };
    "hypr/scripts/reload_waybar" = {
      source = ../../dotfiles/hypr/scripts/reload_waybar;
      executable = true;
    };
  };
}
