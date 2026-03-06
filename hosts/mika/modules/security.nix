{ lib, ... }:

let
  nextcloudSecretFile = ../../../secrets/nextcloud-admin-pass.age;
  hasNextcloudSecret = builtins.pathExists nextcloudSecretFile;
in

{
  age.secrets = lib.mkIf hasNextcloudSecret {
    nextcloud-admin-pass = {
      file = nextcloudSecretFile;
      owner = "nextcloud";
      group = "nextcloud";
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
