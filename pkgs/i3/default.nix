{ pkgs, lib, ... }:
let
  mod = "Mod4";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      keybindings = lib.mkOptionDefault {
        "Print" = "exec flameshot gui";
        "${mod}+m" = "exec rofi -show drun";
        "${mod}+z" = "exec firefox";
        "${mod}+t" = "exec tor-browser";
        "${mod}+Shift+c" = "exec mullvad connect";
        "${mod}+Shift+d" = "exec mullvad disconnect";
        "${mod}+Shift+l" = "exec feh --bg-fill --randomize ~/dotfiles/backgrounds/*";
      };
      terminal = "alacritty";
      modifier = mod;
      defaultWorkspace = "workspace number 1";
      startup = [
        { command = "exec xset r rate 200 30"; always = true; notification = false; }
        { command = "exec feh --bg-fill ~/dotfiles/backgrounds/*"; always = true; notification = false; }
        { command = "exec mullvad connect"; always = true; notification = true; }
      ];
    };
  };
}
