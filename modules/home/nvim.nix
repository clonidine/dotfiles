{ pkgs, self, ... }:

let
  inherit (import ../../pkgs/neovim/shared.nix { inherit pkgs; })
    extraPackages
    ;
in

{
  home.packages = [
    self.packages.${pkgs.stdenv.hostPlatform.system}.dotfiles-neovim
  ] ++ extraPackages;

  xdg.configFile."nvim" = {
    source = ../../dotfiles/nvim;
    force = true;
  };
}
