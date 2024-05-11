{ pkgs, ...}: {
    imports = [
       ./alacritty
       ./git
       ./mullvad
	./gpg
	./zsh
	./firefox
        ./vscodium
	./i3
	./rofi
	./syncthing
   ];
    
    home.username = "mig";
    home.homeDirectory = "/home/mig";
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
	tor-browser
	keepassxc
      	neofetch
	rustup
      	git
	alacritty
	flameshot
	gccgo13
        bat
	eza
	pinentry
	gnupg
        zsh
        oh-my-zsh
	lunar-client
   ];
}
