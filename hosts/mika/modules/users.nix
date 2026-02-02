{ pkgs, ... }:

{
  users.users.mika = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$F2A4KFI4TvQ6luMk6Gayo/$BcdQa7Es8B75rdxwv3bpq0Uj1jtyer0evMJKc2HVIdB";
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

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
