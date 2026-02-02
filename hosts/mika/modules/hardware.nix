{ lib, config, ... }:

{
  hardware.bluetooth.enable = true;

  # NVIDIA setup
  services.xserver.videoDrivers = lib.mkForce [ "nvidia" ];

  hardware.cpu.amd.updateMicrocode = true;

  hardware.uinput.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia-container-toolkit = {
    enable = true;
    suppressNvidiaDriverAssertion = true;
  };
}
