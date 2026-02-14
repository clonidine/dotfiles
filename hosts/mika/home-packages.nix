{ pkgs, inputs, ... }:

{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    jetbrains.idea
    tor-browser
    onionshare-gui
    mpvpaper
    variety
    bluez
    cargo-generate
    cargo-expand
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
    kdePackages.kwallet
    gnugrep
    inputs.lunar-client.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
