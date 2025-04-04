{ pkgs, ... }:

{
  home.packages = with pkgs; [
    playerctl
    pavucontrol
    busybox
    mpd
    wlogout
    pulseaudio
  ];

  programs.waybar.enable = true;

  xdg.configFile = {
    "waybar/config.jsonc".source = ../../dotfiles/waybar/config.jsonc;
    "waybar/mocha.css".source = ../../dotfiles/waybar/mocha.css;
    "waybar/style.css".source = ../../dotfiles/waybar/style.css;

    "waybar/wlogout/scripts/wlogout" = {
      source = ../../dotfiles/waybar/scripts/wlogout;
      executable = true;
    };
  };
}
