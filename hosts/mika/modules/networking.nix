{ ... }:

{
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  networking.nftables.enable = true;
  networking.firewall.enable = false;

  networking.nftables.ruleset = ''
    table inet filter {
     chain input {
        type filter hook input priority 0; policy drop;

        iif "lo" accept
        ct state established,related accept

        tcp dport { 80, 443 } accept

        udp dport 5353 accept 
        ip protocol icmp accept
      }

      chain forward {
          type filter hook forward priority 0; policy drop;
          ct state established,related accept
          iifname "zt*" accept
          oifname "zt*" accept
      }

      chain output {
        type filter hook output priority 0; policy accept;
      }
    }
  '';

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";
}
