{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
  ];

  xdg.configFile."nvim/init.lua".source = ../../dotfiles/nvim/init.lua;
  xdg.configFile."nvim/lua/plugins.lua".source = ../../dotfiles/nvim/lua/plugins.lua;
}
