{ pkgs, ... }:

{
  programs.virt-manager.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  programs.hyprland.enable = true;

  programs.zsh.enable = true;

}
