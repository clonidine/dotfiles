{ ... }:

{
  imports = [
    ../../modules/home/mpv.nix
    ../../modules/home/alacritty.nix
    ../../modules/home/git.nix
    ../../modules/home/vencord.nix
    ../../modules/home/bat.nix
    ../../modules/home/spicetify.nix
    ../../modules/home/zsh.nix
    ../../modules/home/vscode.nix
    ../../modules/home/firefox.nix
    ../../modules/home/direnv.nix
    ../../modules/home/nvim.nix
    ../../modules/home/wireplumber.nix

    ../../modules/desktop/gnome.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/rofi/rofi.nix
    ../../modules/desktop/waybar.nix
    ../../modules/desktop/wlogout.nix
  ];
}
