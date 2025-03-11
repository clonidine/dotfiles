{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "clonidine";
    userEmail = "lcly@duck.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
