{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains.idea-community
    android-studio
    jetbrains.rust-rover
  ];
}
