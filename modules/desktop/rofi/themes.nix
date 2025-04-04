{ pkgs, ... }:

let
  themes = [
    # "catppuccin-frappe.rasi"
    # "catppuccin-latte.rasi"
    # "catppuccin-macchiato.rasi"
    "catppuccin-mocha.rasi"
  ];
in {
  home.file = builtins.listToAttrs (map (fileName: {
    name = ".config/rofi/themes/${fileName}";
    value = { source = ../../../dotfiles/rofi/themes/${fileName}; };
  }) themes);
}
