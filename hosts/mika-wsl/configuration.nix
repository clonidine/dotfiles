{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.nixos-wsl.nixosModules.default ];

  wsl = {
    enable = true;
    defaultUser = "mika";
    startMenuLaunchers = true;

    # Keep PATH deterministic and rely on explicit Windows interop when needed.
    interop.includePath = false;
    wslConf.interop.appendWindowsPath = false;
  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos-wsl";
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.mika = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  # WSL boots without a local password by default, so wheel needs to stay passwordless
  # until the user decides to add a password manually.
  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    fastfetch
    git
    gnugrep
    gnutar
    jq
    nixfmt
    unzip
    vim
    wget
    zip
  ];

  system.stateVersion = "25.05";
}
