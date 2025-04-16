{ pkgs, ... }:

{
  programs.alacritty.enable = true;

  xdg.configFile = {
    "alacritty/alacritty.toml".source = ../../dotfiles/alacritty/alacritty.toml;

    "alacritty/themes/catppuccin_mocha.toml".source =
      ../../dotfiles/alacritty/themes/catppuccin_mocha.toml;

    "alacritty/themes/github_dark_high_contrast.toml".source =
      ../../dotfiles/alacritty/themes/github_dark_high_contrast.toml;
  };
}
