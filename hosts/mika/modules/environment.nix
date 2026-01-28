{ pkgs, inputs, ... }:

let
  signalKwallet = pkgs.symlinkJoin {
    name = "signal-desktop-kwallet";
    paths = [ pkgs.signal-desktop ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/signal-desktop \
        --add-flags "--password-store=kwallet6"
    '';
  };
in
{
  environment.pathsToLink = [ "/libexec" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default 
    fastfetch
    vim
    wget
    curl
    nixfmt
    qemu
    spice-gtk
    freerdp   # xfreerdp + wlfreerdp
    remmina   # optional GUI client
    signalKwallet
    kdePackages.kwallet
    kdePackages.kwalletmanager
    kdePackages.kwallet-pam
  ];
}
