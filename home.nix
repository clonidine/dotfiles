{
  config,
  pkgs,
  lib,
  ...
}:

{

  nixpkgs.config.allowBroken = true;

  home.username = "mika";
  home.homeDirectory = "/home/mika";

  home.stateVersion = "23.11";

  programs.firefox.enable = true;

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    mullvad-browser
    telegram-desktop
    htop
    wl-clipboard
    grim
    slurp
    vscodium
    alsa-utils
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    keepassxc
    bat
    eza
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  imports = [
    ./modules/home/mpv.nix
    ./modules/home/alacritty.nix
    ./modules/home/git.nix
    ./modules/home/vencord.nix
    ./modules/home/bat.nix
    ./modules/home/spicetify.nix
    ./modules/home/zsh.nix

    ./modules/desktop/gnome.nix
    ./modules/desktop/hyprland.nix
    ./modules/desktop/rofi/rofi.nix
    ./modules/desktop/waybar.nix
    ./modules/desktop/wlogout.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
