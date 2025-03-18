{ pkgs, ... }:

{
  #  Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mika = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      mullvad-browser
      fastfetch
      telegram-desktop
    ];
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
