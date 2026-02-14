{ pkgs, ... }:

let
  configFolder = "Vencord";
in
{
  home.packages = [
    pkgs.vesktop
    pkgs.discord
    #    (pkgs.discord.override {
    #      withVencord = true;
    #      withOpenASAR = false;

  ];

  xdg.desktopEntries."vesktop" = {
    name = "Vesktop";
    exec = "vesktop %U";
    icon = "discord";
    terminal = false;
    categories = [
      "Network"
      "Chat"
    ];
    mimeType = [ "x-scheme-handler/discord" ];
  };

  xdg.configFile = {
    "${configFolder}/settings/settings.json".source = ../../dotfiles/Vencord/settings/settings.json;
    "${configFolder}/settings/quickCss.css".source = ../../dotfiles/Vencord/settings/quickCss.css;
    "${configFolder}/themes/catppuccin-mocha.theme.css".source =
      ../../dotfiles/Vencord/themes/catppuccin-mocha.theme.css;
  };
}
