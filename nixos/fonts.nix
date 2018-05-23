{ config, pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      terminus_font
      twemoji-color-font
      google-fonts
      noto-fonts-emoji
      symbola
      nerdfonts
    ];
  };
}
