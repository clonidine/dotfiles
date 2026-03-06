{
  pkgs,
  lib,
  config,
  ...
}:

let
  passwordSecretFile = ../../../secrets/mika-password-hash.age;
  hasPasswordSecret = builtins.pathExists passwordSecretFile;
in

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
  }
  // lib.optionalAttrs hasPasswordSecret {
    hashedPasswordFile = config.age.secrets.mika-password-hash.path;
  }
  // lib.optionalAttrs (!hasPasswordSecret) {
    hashedPassword = "$y$j9T$F2A4KFI4TvQ6luMk6Gayo/$BcdQa7Es8B75rdxwv3bpq0Uj1jtyer0evMJKc2HVIdB";
  };

  age.secrets = {
    mika-ssh = {
      file = ../../../secrets/mika-ssh.age;

      path = "/home/mika/.ssh/id_ed25519";
      owner = "mika";
      mode = "600";
    };
  }
  // lib.optionalAttrs hasPasswordSecret {
    mika-password-hash = {
      file = passwordSecretFile;
      owner = "root";
      group = "root";
      mode = "0400";
    };
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
