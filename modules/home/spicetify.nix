{ pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.spicetify ];

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts
      adblock
      playlistIcons
      historyShortcut
      fullAlbumDate
    ];

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
