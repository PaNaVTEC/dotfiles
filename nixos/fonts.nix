{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      twemoji-color-font
      symbola
      nerdfonts
      font-awesome
      iosevka-bin
      cantarell-fonts
    ];
  };
}
