{ pkgs, lib, ... }: 
let
  mod = "Mod4";
in
{
  xsession.windowManager.i3 = {
     enable = true;
     config = {
       keybindings = lib.mkOptionDefault {
        "Print" = "exec flameshot gui"; 
	"${mod}+m" = "exec rofi -show drun";
        "${mod}+z" = "exec firefox";
	"${mod}+t" = "exec tor-browser";
        "${mod}+Shift+c" = "exec mullvad connect";
	"${mod}+Shift+d" = "exec mullvad disconnect";
      };
     terminal = "alacritty";
     modifier = mod;
     defaultWorkspace = "workspace number 1";
     startup = [
	{ command = "exec mullvad connect"; always = true; notification = true; }
        
        { command = "mkdir -p ~/Documents"; always = false; notification = false; }
	{ command = "mkdir -p ~/Documents/KeePassXC"; always = false; notification = false; }
      ];
    };
  };
}
