{pkgs, ...}: {
    programs.alacritty = {
	enable = true;
	settings.font = { 
           normal.family = "JetBrains Mono Nerd Font";
	   bold.family = "JetBrains Mono Nerd Font";
     	   italic.family = "JetBrains Mono Nerd Font";
       };
   };
}
