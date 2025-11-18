{ pkgs, ... }:

{
  environment.pathsToLink = [ "/libexec" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    fastfetch
    vim
    wget
    curl
    nixfmt-rfc-style
    qemu
    spice-gtk
    freerdp   # xfreerdp + wlfreerdp
    remmina   # optional GUI client
  ];
}
