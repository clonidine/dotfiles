{ pkgs, options, ... }: {
  options.services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
