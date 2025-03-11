{ config, pkgs, lib, ... }:

let
  myAliases = {
    # Git
    g = "git";
    ga = "git add";
    gs = "git status";
    gl = "git log";
    gd = "git diff";
    gc = "git commit";
    gp = "git push";

    # Others
    ls = "eza";
    cat = "bat";
    hrbd = "home-manager switch --flake .#mika";
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

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    fira-code
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
