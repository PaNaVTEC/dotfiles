{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    # displayManager.startx.enable = true;
    # desktopManager.plasma5.enable = true;
    desktopManager.gnome.enable = true;
    # windowManager.i3 = {
    #   package = pkgs.i3-gaps;
    #   enable = true;
    # };
    libinput.enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    exportConfiguration = true;
    videoDrivers=["amdgpu"];
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
    sysstat
    # dmenu
    # dunst
    # i3blocks
    # i3lock-pixeled
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

    gnomeExtensions.appindicator
    gnomeExtensions.just-perfection
    gnomeExtensions.draw-on-you-screen-2
    gnomeExtensions.duckduckgo-search-provider
    gnomeExtensions.vitals
    gnomeExtensions.extensions-sync
    gnomeExtensions.unite
    gnomeExtensions.forge
    gnome.dconf-editor
  ];
}
