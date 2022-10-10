{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    # displayManager.startx.enable = true;
    # desktopManager.plasma5.enable = true;
    desktopManager.gnome.enable = true;
    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
    };
    libinput.enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    exportConfiguration = true;
  };

  environment.variables = {
    XCURSOR_SIZE= "32";
  };

  environment.gnome.excludePackages = with pkgs.gnome; [
    gnome-maps
    gnome-terminal
    gnome-music
    epiphany
    geary
    cheese
  ];

  environment.systemPackages = with pkgs; [
    xorg.xkill
    xorg.xwininfo
    xorg.xdpyinfo
    xorg.xprop
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
    picom
    evince
    cups
    system-config-printer
    # Gnome
    unstable.gnome.gnome-tweaks

    unstable.gnomeExtensions.pop-shell
    unstable.gnomeExtensions.appindicator
    unstable.gnomeExtensions.just-perfection
    unstable.gnomeExtensions.draw-on-you-screen-2
    unstable.gnomeExtensions.sound-output-device-chooser
    unstable.gnomeExtensions.duckduckgo-search-provider
    unstable.gnomeExtensions.bitcoin-markets
    unstable.gnomeExtensions.vitals
    unstable.gnomeExtensions.extensions-sync
    unstable.gnomeExtensions.workspaces-bar
    unstable.gnomeExtensions.unite
    unstable.gnomeExtensions.forge
    gnome.dconf-editor
  ];
}
