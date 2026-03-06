{
  pkgs,
  config,
  ...
}:

{
  users.mutableUsers = false;

  users.users.mika = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "wireshark"
      "libvirtd"
      "kvm"
      "input"
      "uinput"
    ];
    hashedPasswordFile = config.age.secrets.mika-password-hash.path;
  };

  age.secrets = {
    mika-ssh = {
      file = ../../../secrets/mika-ssh.age;

      path = "/home/mika/.ssh/id_ed25519";
      owner = "mika";
      mode = "600";
    };

    mika-password-hash = {
      file = ../../../secrets/mika-password-hash.age;
      owner = "root";
      group = "root";
      mode = "0400";
    };
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
