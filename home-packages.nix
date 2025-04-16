{ pkgs, ... }:

{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  
  home.packages = with pkgs; [
    blueman
    cargo-generate
    signal-desktop-bin
    obsidian
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
