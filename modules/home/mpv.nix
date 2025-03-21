{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
        ];
        mpv = pkgs.mpv-unwrapped.override { waylandSupport = true; };
      }
    );
  };

  xdg.configFile."mpv/mpv.conf".source = ../../dotfiles/mpv/mpv.conf;

  home.packages = with pkgs; [ yt-dlp ];
}
