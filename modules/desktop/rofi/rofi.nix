{ pkgs, ... }:

{
  home.packages = with pkgs; [ rofi rofi-unwrapped ];

  home.file.".config/rofi/config.rasi".source = ../../../dotfiles/rofi/config.rasi;

  imports = [ ./themes.nix ];
}
