{ pkgs, ... }:

{
  home.packages = with pkgs; [
    p7zip
    mullvad-browser
    telegram-desktop
    htop
    alsa-utils
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    keepassxc
    bat
    eza
  ];
}
