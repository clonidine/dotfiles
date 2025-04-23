{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/environment.nix
  ];

  # Enable AMD graphics acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.virt-manager.enable = true;

  programs.zsh.interactiveShellInit = ''eval "$(direnv hook zsh)"'';

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Hyprland
  programs.hyprland.enable = true;

  # Sound configuration
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable OpenSSH daemon
  services.openssh.enable = true;

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # System state version
  system.stateVersion = "25.05"; # Did you read the comment?
}
