{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    plugins = with pkgs; [ zsh-autosuggestions ];
    dotDir = ".config/zsh";
  };
}
