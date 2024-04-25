{ pkgs, ...}: {
    imports = [
       ./alacritty
       ./git
       ./mullvad
	./gpg
	./zsh
	./firefox
   ];
    
    home.username = "mig";
    home.homeDirectory = "/home/mig";
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
	tor-browser
	keepassxc
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
        zsh
        oh-my-zsh
   ];
}
