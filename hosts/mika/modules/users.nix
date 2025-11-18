{ pkgs, ... }:

{
  users.users.mika = {
    isNormalUser = true;
    hashedPassword = "REDACTED_PASSWORD_HASH";
    extraGroups = [
      "wheel"
      "networkmanager"
      "wireshark"
      "libvirtd"
      "kvm"
    ];
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
