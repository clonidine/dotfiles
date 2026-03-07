{ pkgs, ... }:

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
      hbmac = "home-manager switch --flake .#mika@macbook";
    };
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "clonidine";
      email = "86500701+clonidine@users.noreply.github.com";
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
