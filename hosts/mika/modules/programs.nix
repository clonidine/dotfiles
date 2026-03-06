{ pkgs, ... }:

{
  programs.virt-manager.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  programs.dconf.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL
    glfw
    openal
    libpulseaudio
    libx11
    libxcursor
    libxrandr
    libxext
    libxxf86vm
    stdenv.cc.cc
    flite
    libudev0-shim
    udev
    libevent
    libffi
    libjpeg
    libpng
    libvpx
    libxml2
    libwebp
    libxinerama
    libxi
  ];

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";

  programs.hyprland.enable = true;

  programs.zsh.enable = true;

  programs.steam.enable = true;
}
