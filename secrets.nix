let
  mika = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5ipYjy2mBU8zthIVQTVX9wUHw3jutXJGqVxRSg/Gnw lcly@tuta.io";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKRx0bHeNORTfI0meodXxgfWnjSf+LISw4RHYEcyZzLG root@nixos";
in
{
  "secrets/mika-ssh.age".publicKeys = [
    mika
    desktop
  ];
}
