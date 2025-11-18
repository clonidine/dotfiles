{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
    	user.name = "clonidine";
    	user.email = "lcly@duck.com";
        init.defaultBranch = "main";
    };
  };
}
