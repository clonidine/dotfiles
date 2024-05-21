{ pkgs, config, lib, ... }: {
  imports = [
    (import
      (builtins.fetchurl {
        url = "https://gist.githubusercontent.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa/raw/41e569ba110eb6ebbb463a6b1f5d9fe4f9e82375/mutability.nix";
        sha256 = "4b5ca670c1ac865927e98ac5bf5c131eca46cc20abf0bd0612db955bfc979de8";
      })
      { inherit config lib; })

    (import
      (builtins.fetchurl {
        url = "https://gist.githubusercontent.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa/raw/41e569ba110eb6ebbb463a6b1f5d9fe4f9e82375/vscode.nix";
        sha256 = "fed877fa1eefd94bc4806641cea87138df78a47af89c7818ac5e76ebacbd025f";
      })
      { inherit config lib pkgs; })
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = {
      "files.autoSave" = "afterDelay";
      "editor.fontSize" = 16;
      "editor.fontFamily" = "'JetBrainsMono Nerd Font'";
      "editor.cursorStyle" = "line";
      "editor.fontLigatures" = true;
      "workbench.colorTheme" = "Catppuccin Mocha";
      "files.associations" = {
        "*.yaml" = "dockercompose";
      };
    };
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      ms-azuretools.vscode-docker
      usernamehw.errorlens
      vscodevim.vim
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      equinusocio.vsc-material-theme-icons
      serayuzgur.crates
    ];
  };
}
