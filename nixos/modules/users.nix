{ pkgs, ... }:

{
  #  Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mika = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "wireshark"
    ];
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
