# Mika's Dotfiles

This repository is a flake with three active targets:

- `mika`: main NixOS desktop host
- `mika-wsl`: NixOS-WSL host for WSL2
- `mika-macbook`: macOS host via `nix-darwin`

It also exposes standalone Home Manager targets:

- `mika`
- `mika@wsl`
- `mika@macbook`

## Repo setup

Clone the repo and enter it:

```sh
git clone git@github.com:clonidine/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Personal and host-specific values are intentionally split from the public repo.
Before applying the flake on your own machines, copy the example private config and
fill in your real values:

```sh
cp private/local.nix.example private/local.nix
$EDITOR private/local.nix
```

Use `path:$PWD#...` when applying the flake locally. Plain `.#...` uses the Git
snapshot of the repo and will not see the gitignored `private/local.nix`.

## Private overrides

The `private/` directory separates public defaults from machine-specific values:

- [private/default.nix](private/default.nix)
  sanitized placeholders that are safe to publish
- [private/local.nix.example](private/local.nix.example)
  template for real local values
- `private/local.nix`
  your real private values, ignored by Git
- [private/config.nix](private/config.nix)
  merges public defaults with local overrides

Put values like these in `private/local.nix`:

- Git name and email
- SSH signing public key
- `agenix` recipients
- private network identifiers such as ZeroTier network IDs

Inspect the available outputs:

```sh
nix flake show
```

## Main NixOS host: `mika`

This is the full desktop machine in [hosts/mika/configuration.nix](hosts/mika/configuration.nix).

Important:

- this host uses `agenix`
- system secrets are referenced during `nixos-rebuild`
- on a fresh machine you should restore the SSH identities used for `agenix` first

If you already restored your keys:

```sh
cd ~/dotfiles
sudo nixos-rebuild switch --flake path:$PWD#mika
```

This Linux host uses standalone Home Manager, so apply it separately:

```sh
cd ~/dotfiles
home-manager switch --flake path:$PWD#mika
```

If `home-manager` is not installed yet:

```sh
cd ~/dotfiles
nix shell nixpkgs#home-manager -c home-manager switch --flake path:$PWD#mika
```

## WSL2 host: `mika-wsl`

This is the minimal WSL2 target in [hosts/mika-wsl/configuration.nix](hosts/mika-wsl/configuration.nix).

Build the WSL tarball builder from the repo root:

```sh
cd ~/dotfiles
nix build path:$PWD#mika-wsl-tarball-builder
```

Or run the builder directly:

```sh
cd ~/dotfiles
nix run path:$PWD#mika-wsl-tarball-builder
```

After importing the WSL image and entering the instance, apply the host:

```sh
cd ~/dotfiles
sudo nixos-rebuild switch --flake path:$PWD#mika-wsl
```

Then apply the standalone Home Manager config for WSL:

```sh
cd ~/dotfiles
home-manager switch --flake path:$PWD#mika@wsl
```

There is a host-specific note file in [hosts/mika-wsl/README.md](hosts/mika-wsl/README.md).

## macOS host: `mika-macbook`

This target is managed by `nix-darwin` in [hosts/mika-macbook/darwin.nix](hosts/mika-macbook/darwin.nix).

Apply the system with `darwin-rebuild`:

```sh
cd ~/dotfiles
darwin-rebuild switch --flake path:$PWD#mika-macbook
```

If `darwin-rebuild` is not installed yet:

```sh
cd ~/dotfiles
nix run github:LnL7/nix-darwin/master#darwin-rebuild -- switch --flake path:$PWD#mika-macbook
```

This host already integrates Home Manager through `nix-darwin`, so you normally do not need a separate Home Manager step.

## Useful commands

Main desktop:

```sh
sudo nixos-rebuild switch --flake path:$PWD#mika
home-manager switch --flake path:$PWD#mika
```

WSL:

```sh
sudo nixos-rebuild switch --flake path:$PWD#mika-wsl
home-manager switch --flake path:$PWD#mika@wsl
```

macOS:

```sh
darwin-rebuild switch --flake path:$PWD#mika-macbook
```

Neovim package/dev shell:

```sh
nix build path:$PWD#dotfiles-neovim
nix develop
```

## Fresh install notes

For the main `mika` NixOS host, `agenix` matters.

At minimum, make sure these identities exist before the first successful rebuild:

- your user SSH key at `~/.ssh/id_ed25519`
- the host SSH key if you want to preserve the existing `desktop` identity used by `secrets.nix`

Without that, the host can fail when evaluating or realizing secrets from `secrets/*.age`.

Public safety note:

- tracked defaults in [private/default.nix](private/default.nix) are sanitized placeholders
- your real local values belong in `private/local.nix`, which is gitignored

## Validation

After applying a target:

```sh
git status
nix flake show
```

For Linux Home Manager targets:

```sh
home-manager generations
```

For SSH-backed Git access:

```sh
ssh -T git@github.com
```
