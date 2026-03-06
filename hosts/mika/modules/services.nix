{ pkgs, config, ... }:

let
  bootstrapAdminUser = "bootstrap-admin";
  operatorUser = "mika";
  occCmd = "/run/current-system/sw/bin/nextcloud-occ";
in

{
  services.openssh.enable = true;

  services.blueman.enable = true;

  services.fwupd.enable = true;

  services.tor.enable = true;
  services.tor.client.enable = true;

  services.tailscale.enable = false;

  services.zerotierone = {
    enable = true;
    port = 9993;
    joinNetworks = [ "0000000000000000" ];
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;

    settings = {
      listen_addresses = "localhost";
    };

    ensureDatabases = [ "ranked" ];

    ensureUsers = [
      {
        name = "ranked";
        ensureDBOwnership = true;
      }
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d /etc/ssl/local 0750 root nginx -"
    "z /etc/ssl/local/cloud.local-key.pem 0640 root nginx -"
  ];

  services.nginx = {
    enable = true;
    virtualHosts."nixos.local" = {
      forceSSL = true;
      sslCertificate = "/etc/ssl/local/cloud.local.pem";
      sslCertificateKey = "/etc/ssl/local/cloud.local-key.pem";

      extraConfig = ''
        ssl_protocols TLSv1.2 TLSv1.3;
        ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256;
      '';
    };
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = "nixos.local";
    https = false;

    settings = {
      overwriteprotocol = "https";
      overwritehost = "nixos.local";
    };

    config = {
      adminuser = bootstrapAdminUser;
      adminpassFile = config.age.secrets.nextcloud-admin-pass.path;
      dbtype = "pgsql";
    };
    database.createLocally = true;
  };

  systemd.services.nextcloud-bootstrap-hardening = {
    description = "Ensure operational Nextcloud admin and disable bootstrap admins";
    after = [ "nextcloud-setup.service" ];
    requires = [ "nextcloud-setup.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      set -euo pipefail

      oc_pass="$(${pkgs.coreutils}/bin/cat ${config.age.secrets.nextcloud-mika-pass.path})"

      if ! ${pkgs.sudo}/bin/sudo -u nextcloud ${occCmd} user:info ${operatorUser} >/dev/null 2>&1; then
        ${pkgs.sudo}/bin/sudo -u nextcloud ${pkgs.coreutils}/bin/env \
          OC_PASS="$oc_pass" \
          NC_PASS="$oc_pass" \
          ${occCmd} user:add \
          --password-from-env \
          --display-name "Mika" \
          ${operatorUser}
      fi

      ${pkgs.sudo}/bin/sudo -u nextcloud ${pkgs.coreutils}/bin/env \
        OC_PASS="$oc_pass" \
        NC_PASS="$oc_pass" \
        ${occCmd} user:resetpassword \
        --password-from-env \
        ${operatorUser}

      ${pkgs.sudo}/bin/sudo -u nextcloud ${occCmd} group:adduser admin ${operatorUser} >/dev/null 2>&1 || true

      for user in admin ${bootstrapAdminUser}; do
        if ${pkgs.sudo}/bin/sudo -u nextcloud ${occCmd} user:info "$user" >/dev/null 2>&1; then
          ${pkgs.sudo}/bin/sudo -u nextcloud ${occCmd} user:disable "$user" || true
        fi
      done

      unset oc_pass
    '';
  };

  systemd.services.zerotier-enable-multicast = {
    description = "Enable multicast on ZeroTier interfaces (zt*) for LAN discovery/broadcast";
    after = [
      "zerotierone.service"
      "network-online.target"
    ];
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

  #  services.xserver.xkb.layout = "us";
  #  services.xserver.xkb.variant = "intl";

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
  services.displayManager.gdm.wayland = true;
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  services.gvfs.enable = true;

  services.dbus.packages = with pkgs; [
    kdePackages.kwallet
  ];

  systemd.services.libvirt-default-network = {
    description = "Start libvirt default network";
    after = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.libvirt}/bin/virsh net-start default";
      ExecStop = "${pkgs.libvirt}/bin/virsh net-destroy default";
      User = "root";
    };
  };

  services.desktopManager.plasma6.enable = false;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput"

    SUBSYSTEM=="input", KERNEL=="event*", MODE="0640", GROUP="input"
  '';

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    loadModels = [
      # "llama3.1:8b"
      "qwen2.5-coder:7b"
      "deepseek-r1:7b"
    ];

    # syncModels = true;
    # openFirewall = true;
  };

}
