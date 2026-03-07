{ ... }:

{
  programs.kitty.enable = true;

  xdg.configFile."kitty/kitty.conf".source = ../../dotfiles/kitty/kitty.conf;
}
