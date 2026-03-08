let
  private = import ./private/config.nix;
  mika = private.agenix.userRecipient;
  desktop = private.agenix.hostRecipients.desktop;
in
{
  "secrets/mika-ssh.age".publicKeys = [
    mika
    desktop
  ];

  "secrets/mika-password-hash.age".publicKeys = [
    mika
    desktop
  ];

  "secrets/nextcloud-admin-pass.age".publicKeys = [
    mika
    desktop
  ];

  "secrets/nextcloud-mika-pass.age".publicKeys = [
    mika
    desktop
  ];
}
