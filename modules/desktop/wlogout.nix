{ pkgs, ... }:

{
  xdg.configFile = {
    "wlogout/layout".source = ../../dotfiles/wlogout/layout;
    "wlogout/style.css".source = ../../dotfiles/wlogout/style.css;

    "wlogout/icons/hibernate.svg".source = ../../dotfiles/wlogout/icons/hibernate.svg;
    "wlogout/icons/lock.svg".source = ../../dotfiles/wlogout/icons/lock.svg;
    "wlogout/icons/logout.svg".source = ../../dotfiles/wlogout/icons/logout.svg;
    "wlogout/icons/reboot.svg".source = ../../dotfiles/wlogout/icons/reboot.svg;
    "wlogout/icons/shutdown.svg".source = ../../dotfiles/wlogout/icons/shutdown.svg;
    "wlogout/icons/suspend.svg".source = ../../dotfiles/wlogout/icons/suspend.svg;
  };
}
