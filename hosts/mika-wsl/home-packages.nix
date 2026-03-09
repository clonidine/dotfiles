{ pkgs, ... }:

{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    bat
    cargo-expand
    cargo-generate
    eza
    fd
    gnugrep
    htop
    jq
    keepassxc
    maven
    monocraft
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    p7zip
    ripgrep
    vscodium
  ];
}
