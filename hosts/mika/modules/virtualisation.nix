{ inputs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "start";
  };
}
