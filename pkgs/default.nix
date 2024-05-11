{ pkgs, ... }: {
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
    ./rust
  ];

  home.username = "mig";
  home.homeDirectory = "/home/mig";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    feh
    tor-browser
    keepassxc
    fastfetch
    flameshot
    gccgo13
    bat
    eza
    pinentry
    gnupg
    lunar-client
    nixpkgs-fmt
  ];
}
