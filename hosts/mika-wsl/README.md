# WSL Host

This host is the minimal WSL2/NixOS target.

Useful commands from the repo root:

```sh
nix flake show
nix build path:$PWD#mika-wsl-tarball-builder
nix run path:$PWD#mika-wsl-tarball-builder
sudo nixos-rebuild switch --flake path:$PWD#mika-wsl
home-manager switch --flake path:$PWD#mika@wsl
```

The WSL host intentionally skips the desktop, hardware, virtualization, and
service-heavy modules used by the main Linux machine.
