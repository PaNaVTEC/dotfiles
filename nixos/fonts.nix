{ config, pkgs, ... }:

let
  terminus-td1 = pkgs.stdenv.lib.overrideDerivation pkgs.terminus_font (oldAttrs : {
    configurePhase = ''
      patch < alt/td1.diff
      sh ./configure --prefix=$out
    '';
  });
in
{
  fonts = {
    fonts = with pkgs; [
      terminus-td1
      twemoji-color-font
      google-fonts
      noto-fonts-emoji
      symbola
      nerdfonts
    ];
  };
}
