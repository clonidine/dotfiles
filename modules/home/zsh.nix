{ pkgs, ... }:

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
    rbd = "sudo nixos-rebuild switch --flake .#mika";
    ff = "fastfetch";
  };
in
{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        # {
        #   name = "romkatv/powerlevel10k";
        #   tags = [
        #     "as:theme"
        #     "depth:1"
        #   ];
        # }
      ];
    };
    enableCompletion = true;
    shellAliases = myAliases;
  };
}
