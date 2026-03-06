let
  mika = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMo1dnyX/XPyCf4+YXy7a5zvCOcVTocrv1EB6q3Q5PSD user@example.invalid";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvDX++PFPyQgxPNSP9RLMnWEIJ9NQepJv7w5S0ovOUT host.invalid@nixos";
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
