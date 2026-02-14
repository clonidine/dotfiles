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
      "input"
      "uinput"
    ];
  };

  age.secrets.mika-ssh = {
    file = ../../../secrets/mika-ssh.age;

    path = "/home/mika/.ssh/id_ed25519";
    owner = "mika";
    mode = "600";
  };
  
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
