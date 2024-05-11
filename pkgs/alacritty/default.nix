{ pkgs, ... }:

{
  imports = [
    # Themes
    #    ./themes/catppuccin/mocha.nix
    #    ./themes/github/github_dark_high_contrast.nix
    ./themes/inferno.nix
    #    ./themes/midnight-haze.nix

    ./font.nix
  ];

  programs.alacritty.enable = true;
}
