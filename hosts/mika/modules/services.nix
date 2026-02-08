{ pkgs, ... }:

{
  services.openssh.enable = true;

  services.blueman.enable = true;

  services.fwupd.enable = true;

  services.tor.enable = true;
  services.tor.client.enable = true;

  services.tailscale.enable = true;

  services.zerotierone = { enable = true; port = 9993; joinNetworks = [ "3b19b3a71656275d" ]; };
  
  systemd.services.zerotier-enable-multicast = {
    description = "Enable multicast on ZeroTier interfaces (zt*) for LAN discovery/broadcast";
    after = [ "zerotierone.service" "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      set -euo pipefail
      for i in $(seq 1 20); do
        if ls /sys/class/net 2>/dev/null | grep -qE '^zt'; then
          break
        fi
        sleep 0.2
      done

      for iface in $(ls /sys/class/net | grep -E '^zt'); do
        ${pkgs.iproute2}/bin/ip link set dev "$iface" multicast on || true
      done
    '';
  };

  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the ly as the Display Manager
#  services.displayManager.ly.enable = true;

  # Enable the Mullvad VPN
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  services.gvfs.enable = true;

  services.dbus.packages = with pkgs; [
    kdePackages.kwallet
  ];

  services.desktopManager.plasma6.enable = false;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput"

    SUBSYSTEM=="input", KERNEL=="event*", MODE="0640", GROUP="input"
  '';

}
