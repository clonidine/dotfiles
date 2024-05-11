{ pkgs, ... }:

{
  programs.alacritty.settings.colors = {
    primary = {
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      dim_foreground = "#7f849c";
      bright_foreground = "#cdd6f4";
    };

    cursor = {
      text = "#24273a";
      cursor = "#f4dbd6";
    };

    vi_mode_cursor = {
      text = "#24273a";
      cursor = "#b7bdf8";
    };

    search = {
      matches = {
        foreground = "#24273a";
        background = "#a5adcb";
      };
      focused_match = {
        foreground = "#24273a";
        background = "#a6da95";
      };
    };

    footer_bar = {
      foreground = "#24273a";
      background = "#a5adcb";
    };

    hints = {
      start = {
        foreground = "#24273a";
        background = "#eed49f";
      };
      end = {
        foreground = "#24273a";
        background = "#eed49f";
      };
    };

    selection = {
      text = "#24273a";
      background = "#f4dbd6";
    };

    normal = {
      black = "#494d64";
      red = "#ed8796";
      green = "#a6da95";
      yellow = "#eed49f";
      blue = "#8aadf4";
      magenta = "#f5bde6";
      cyan = "#8bd5ca";
      white = "#b8c0e0";
    };

    bright = {
      black = "#5b6078";
      red = "#ed8796";
      green = "#a6da95";
      yellow = "#eed49f";
      blue = "#8aadf4";
      magenta = "#f5bde6";
      cyan = "#8bd5ca";
      white = "#a5adcb";
    };

    dim = {
      black = "#494d64";
      red = "#ed8796";
      green = "#a6da95";
      yellow = "#eed49f";
      blue = "#8aadf4";
      magenta = "#f5bde6";
      cyan = "#8bd5ca";
      white = "#b8c0e0";
    };
  };
}
