{ pkgs, options, ...}: {
   programs.zsh = {
    enable = true;
    enableCompletion = true;
    prezto.caseSensitive = false;
    autosuggestion.enable = true;
    shellAliases = {
       hrebuild = "home-manager switch --flake";
       rebuild = "sudo nixos-rebuild switch --flake";
       ls = "eza --icons";
       cat = "bat";
    };
    oh-my-zsh = {
     enable = true;
     plugins = [ "git" ];
     theme = "jonathan";
   };
  };
}
