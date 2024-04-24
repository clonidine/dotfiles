{ pkgs, ...}: {
    imports = [
       ./alacritty
       ./git
       ./mullvad
	./gpg
   ];
    
    home.username = "mig";
    home.homeDirectory = "/home/mig";
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
	firefox
	tor-browser
	keepassxc
	firefox
      	neofetch
      	vscodium
      	i3
      	git
	alacritty
	rofi
	flameshot
	rustup
	gccgo13
        bat
	eza
	mullvad-vpn
	pinentry
	gnupg
   ];
}
