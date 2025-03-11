{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    package = (pkgs.mpv-unwrapped.wrapper {
      scripts = with pkgs.mpvScripts; [ uosc sponsorblock ];
      mpv = pkgs.mpv-unwrapped.override { waylandSupport = true; };
    });
  };

  home.file.".config/mpv/mpv.conf".source = ./mpv.conf;

  home.packages = with pkgs; [ yt-dlp ];
}
