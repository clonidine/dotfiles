{ pkgs, ... }:

let
  configFolder = "Vencord";
in
{
  home.packages = [
    (pkgs.discord.override {
      withVencord = true;
    })
  ];

  xdg.configFile = {
    "${configFolder}/settings/settings.json".source = ../../dotfiles/Vencord/settings/settings.json;
    "${configFolder}/settings/quickCss.css".source = ../../dotfiles/Vencord/settings/quickCss.css;
    "${configFolder}/themes/catppuccin-mocha.theme.css".source =
      ../../dotfiles/Vencord/themes/catppuccin-mocha.theme.css;
  };
}
