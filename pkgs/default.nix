{ pkgs, ...}: {
    imports = [
       ./alacritty
       ./git
       ./mullvad
	./gpg
	./zsh
	./firefox
        ./vscodium
   ];
    
    home.username = "mig";
    home.homeDirectory = "/home/mig";
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
	vscodium
	tor-browser
	keepassxc
      	neofetch
	rustup
      	i3
      	git
	alacritty
	rofi
	flameshot
	gccgo13
        bat
	eza
	mullvad-vpn
	pinentry
	gnupg
        zsh
        oh-my-zsh
	lunar-client
	syncthing
   ];
}
