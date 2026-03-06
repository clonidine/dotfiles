{ inputs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "start";
    qemu = {
      swtpm.enable = true;
      runAsRoot = true;
    };
    allowedBridges = [ ];
    extraConfig = ''
      firewall_backend = "none"
    '';
  };
}
