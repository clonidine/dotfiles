{ pkgs, ... }:

let
  configPath = ".config/Vencord";
in
{
  home.packages = [
    (pkgs.discord.override {
      withVencord = true;
    })
  ];

  home.file."${configPath}/themes/catppuccin-mocha.theme.css".source =
    ../../dotfiles/Vencord/themes/catppuccin-mocha.theme.css;

  home.file."${configPath}/settings/quickCss.css".source =
    ../../dotfiles/Vencord/settings/quickCss.css;
  home.file."${configPath}/settings/settings.json".source =
    ../../dotfiles/Vencord/settings/settings.json;
}
