{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "prorealtime";
  version = "2.14";

  src = ./.;

  buildInputs = [ pkgs.openjdk ];

  installPhase = ''
    chmod a+x ./ProRealTime-linux64-2.14.run
    mkdir -p $out/bin $out/share/prorealtime
    ./ProRealTime-linux64-2.14.run
  '';

  meta = with pkgs.lib; {
    description = "ProRealTime trading platform";
    homepage = "https://www.prorealtime.com/";
    license = licenses.unfree;
    platforms = platforms.all;
  };
}
