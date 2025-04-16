{ pkgs, ... }: {
  xdg.configFile."direnv/direnv.toml".source = ../../dotfiles/direnv/direnv.toml;
}
