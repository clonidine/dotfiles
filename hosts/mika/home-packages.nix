{ pkgs, ... }:

{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  
  home.packages = with pkgs; [
    bluez
    cargo-generate
    cargo-expand
    signal-desktop-bin
    obsidian
    obs-studio
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
    ripgrep
    freetube
  ];
}
