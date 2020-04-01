{ config, pkgs, ... }:

let
  i3blocks-hs-contrib = pkgs.haskellPackages.callPackage ./pkgs/i3blocks-hs-contrib { };
in
{
  services.xserver = {
    libinput = {
      disableWhileTyping = true; # doesn't work
      enable = true;
    };
    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
      extraSessionCommands = ''
        compton -c -i 0.95 -b &
        dropbox &
        parcellite -n &
        google-chrome-stable &
        rambox &
        nm-applet &
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    xorg.xkill
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
    parcellite
#    i3blocks-hs-contrib
    masterpdfeditor
    ];
}
