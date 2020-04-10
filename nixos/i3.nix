{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
      extraSessionCommands = ''
        dropbox &
        nm-applet &
      '';
    };
    libinput.enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    exportConfiguration = true;
  };

  environment.systemPackages = with pkgs; [
    xorg.xkill
    xorg.xwininfo
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
#    haskellPackages.i3blocks-hs-contrib
    ];
}
