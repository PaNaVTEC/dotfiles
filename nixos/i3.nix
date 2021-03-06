{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
    };
    libinput.enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    exportConfiguration = true;
  };

  environment.systemPackages = with pkgs; [
    xorg.xkill
    xorg.xwininfo
    xorg.xdpyinfo
    acpi
    dmenu
    dunst
    i3blocks
    sysstat
    i3lock-pixeled
    arandr
    feh

    nordic
    paper-icon-theme
    lxappearance

    maim
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-dropbox-plugin
    xfce.thunar-archive-plugin
    compton
    evince
    gnome3.file-roller
#    haskellPackages.i3blocks-hs-contrib
    ];
}
