{ pkgs, ... }:

let
  themeName = "Catppuccin Mocha.tmTheme";
in
{
  xdg.configFile = {
    "bat/config".source = ../../dotfiles/bat/config;
    "bat/themes/${themeName}".source = ../../dotfiles/bat/themes/${themeName};
  };
}
