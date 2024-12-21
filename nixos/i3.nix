{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
    exportConfiguration = true;
    videoDrivers=["amdgpu"];
  };
  services.libinput.enable = true;

  environment.variables = {
    XCURSOR_SIZE= "32";
  };

  environment.gnome.excludePackages = with pkgs; [
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
    unstable.gnome-tweaks
    cheese

    gnomeExtensions.appindicator
    gnomeExtensions.just-perfection
    # gnomeExtensions.draw-on-you-screen-2
    gnomeExtensions.vitals
    gnomeExtensions.unite
    unstable.gnomeExtensions.forge
    unstable.gnomeExtensions.easyScreenCast
    dconf-editor
  ];
}
