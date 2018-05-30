{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    urxvt_perls
    urxvt_vtwheel
    urxvt_font_size
    rxvt_unicode
  ];
}
