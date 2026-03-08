{ pkgs, lib, ... }:

let
  private = import ../../private/config.nix;
  hasGitIdentity = private.git.userName != null && private.git.userEmail != null;
in

{
  imports = [
    ../../modules/home/codex.nix
    ../../modules/home/nvim.nix
    ../../modules/home/kitty.nix
  ];

  home.username = "mika";
  home.homeDirectory = "/Users/mika";
  home.stateVersion = "25.05";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      g = "git";
      ga = "git add";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
      ls = "eza";
      cat = "bat";
      vim = "nvim";
      hbmac = "home-manager switch --flake path:$HOME/dotfiles#mika@macbook";
    };
  };

  programs.git = {
    enable = true;
    settings = lib.optionalAttrs hasGitIdentity {
      user = {
        name = private.git.userName;
        email = private.git.userEmail;
      };
    };
  };

  home.packages = with pkgs; [
    monocraft
    eza
    bat
    ripgrep
    fd
    jq
    curl
    wget
  ];
}
