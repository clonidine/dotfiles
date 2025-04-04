{ pkgs, ... }:

{
  programs.alacritty.enable = true;

  xdg.configFile."alacritty/alacritty.toml".source = ../../dotfiles/alacritty/alacritty.toml;

  xdg.configFile."alacritty/themes/catppuccin_mocha.toml".source =
    ../../dotfiles/alacritty/themes/catppuccin_mocha.toml;

  xdg.configFile."alacritty/themes/github_dark_high_contrast.toml".source =
    ../../dotfiles/alacritty/themes/github_dark_high_contrast.toml;
}
