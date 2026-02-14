{ pkgs, ... }:

{
  programs.virt-manager.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  
  programs.dconf.enable = true;

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";

  programs.hyprland.enable = true;

  programs.zsh.enable = true;

  programs.steam.enable = true;
}
