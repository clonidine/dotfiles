{ pkgs, ... }:

{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
    theme = pkgs.catppuccin-grub;
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  boot.kernelModules = [ "uinput" ];
}
