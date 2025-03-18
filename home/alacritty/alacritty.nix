{ pkgs, ... }:

{
  programs.alacritty.enable = true;

  home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  home.file.".config/alacritty/themes/catppuccin_mocha.toml".source = ./themes/catppuccin_mocha.toml;
  home.file.".config/alacritty/themes/github_dark_high_contrast.toml".source = ./themes/github_dark_high_contrast.toml;
}
