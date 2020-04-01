{ config, pkgs, ... }:

let
  i3blocks-hs-contrib = pkgs.haskellPackages.callPackage ./pkgs/i3blocks-hs-contrib { };
in
{
  services.xserver = {
    enable = true;

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
  };

  environment.systemPackages = with pkgs; [
    xorg.xkill
    xorg.xauth
    xorg.xbacklight
    xorg.xwininfo
    acpi

    dmenu

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
    compton
#    i3blocks-hs-contrib
    masterpdfeditor
    ];
}
