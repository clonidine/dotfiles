{ lib, ... }:

{
  age.secrets = {
    nextcloud-admin-pass = {
      file = ../../../secrets/nextcloud-admin-pass.age;
      owner = "nextcloud";
      group = "nextcloud";
      mode = "0400";
    };

    nextcloud-mika-pass = {
      file = ../../../secrets/nextcloud-mika-pass.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
  };

  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
    X11Forwarding = false;
    MaxAuthTries = 3;
    LoginGraceTime = "30s";
  };

  security.sudo.wheelNeedsPassword = true;
  security.rtkit.enable = true;
  security.pam.services.gdm.kwallet.enable = true;
  security.pam.services.login.kwallet.enable = true;
}
