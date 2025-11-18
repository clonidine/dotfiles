{
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/services.nix
    ./modules/networking.nix
    ./modules/users.nix
    ./modules/environment.nix
    ./modules/virtualisation.nix
    ./modules/programs.nix
    ./modules/security.nix
    ./modules/hardware.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs.zsh.interactiveShellInit = ''eval "$(direnv hook zsh)"'';

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # System state version
  system.stateVersion = "25.05"; # Did you read the comment?
}
