{ config, pkgs, ... }:

{
  services.xserver.windowManager.i3 = {
    package = pkgs.i3-gaps;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    xorg.xkill
    xorg.xbacklight
    acpi

    dmenu 
    j4-dmenu-desktop

    dunst

    i3blocks
    sysstat

    i3lock-pixeled
    arandr
    feh
    maim
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-dropbox-plugin
    xfce.thunar-archive-plugin
  ];
}
