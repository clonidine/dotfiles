{ pkgs, ... }:

{
  programs.alacritty.settings.colors = {
    primary = {
      background = "0x0a0c10";
      foreground = "0xf0f3f6";
    };

    cursor = {
      text = "0x0a0c10";
      cursor = "0xf0f3f6";
    };

    normal = {
      black = "0x7a828e";
      red = "0xff9492";
      green = "0x26cd4d";
      yellow = "0xf0b72f";
      blue = "0x71b7ff";
      magenta = "0xcb9eff";
      cyan = "0x39c5cf";
      white = "0xd9dee3";
    };

    bright = {
      black = "0x9ea7b3";
      red = "0xffb1af";
      green = "0x4ae168";
      yellow = "0xf7c843";
      blue = "0x91cbff";
      magenta = "0xcb9eff";
      cyan = "0x39c5cf";
      white = "0xd9dee3";
    };
  };
}