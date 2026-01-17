{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    package = (
      pkgs.mpv.override {
	scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
        ];
      }
    );
  };

  xdg.configFile."mpv/mpv.conf".source = ../../dotfiles/mpv/mpv.conf;

  home.packages = with pkgs; [ yt-dlp ];
}
