{ pkgs, ... }:

{
  security.rtkit.enable = true;
  security.pam.services.gdm.kwallet.enable = true;
  security.pam.services.login.kwallet.enable = true;
}
