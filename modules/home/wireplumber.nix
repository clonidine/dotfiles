{ pkgs, ... }:

{
  xdg.configFile."wireplumber/00-default-volume.conf".source = ../../dotfiles/wireplumber/00-default-volume.conf;
}
