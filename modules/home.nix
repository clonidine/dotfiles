{ config, pkgs, lib, ... }:

let
  myAliases = {
    cat = "bat";
    hrbd = "home-manager switch --flake .#mika";

    ga = "git add";
    gc = "git commit";
    gs = "git status";
  };
in {

  nixpkgs.config.allowBroken = true;

  home.username = "mika";
  home.homeDirectory = "/home/mika";

  home.stateVersion = "23.11";

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.firefox.enable = true;

  home.packages = with pkgs; [
    keepassxc
    bat
    eza
    (discord.override {
      withOpenASAR = true;
      # withVencord = true; # can do this here too
    })
  ];

  home.sessionVariables = { EDITOR = "vim"; };

  imports = [
    ../home/mpv/mpv.nix
    ../home/flameshot.nix
    ../home/alacritty/alacritty.nix
    ../home/git.nix

    ../system/dm/gnome.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
