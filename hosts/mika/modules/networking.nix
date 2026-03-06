{ ... }:

let
  wanIf = "enp3s0";
  lanIf = wanIf;
in

{
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  networking.nftables.enable = true;
  networking.firewall.enable = false;

  # Allow the host to route packets (required for VM NAT)
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking.nftables.ruleset = ''
    table inet filter {
      chain input {
        type filter hook input priority 0; policy drop;

        iifname "lo" accept
        ct state established,related accept

        # ZeroTier virtual LAN: expose only required services
        iifname "zt*" tcp dport { 22, 80, 443 } accept

        # Libvirt bridge (DNS/DHCP from VMs to host)
        iifname "virbr0" udp dport { 53, 67, 68 } accept
        iifname "virbr0" tcp dport 53 accept

        # Local LAN services (HTTP/HTTPS + mDNS)
        iifname "${lanIf}" tcp dport { 80, 443 } accept
        iifname "${lanIf}" udp dport 5353 accept
        ip protocol icmp accept
      }

      chain forward {
        type filter hook forward priority 0; policy drop;

        ct state established,related accept

        # ZeroTier forwarding only to/from libvirt network
        iifname "zt*" oifname "virbr0" accept
        iifname "virbr0" oifname "zt*" accept

        # Libvirt NAT: VM -> WAN
        iifname "virbr0" oifname "${wanIf}" accept
        # Return traffic is covered by established,related
      }

      chain output {
        type filter hook output priority 0; policy accept;
      }
    }

    table ip nat {
      chain postrouting {
        type nat hook postrouting priority 100;

        # NAT only when leaving through the WAN interface
        oifname "${wanIf}" ip saddr 192.168.122.0/24 masquerade
      }
    }
  '';

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";
}
