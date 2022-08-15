{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  name = "amazon-corretto-17";
  src = pkgs.fetchzip {
    # https://docs.aws.amazon.com/corretto/latest/corretto-17-ug/downloads-list.html
    url = "https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz";
    sha256 = "sha256-7qhNB+QqknDh1BJZlkfz+ou+IN9eYfmYGTV91ifN8Y0=";
  };
  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.alsa-lib
    pkgs.xorg.libXrender
    pkgs.xorg.libXext
    pkgs.xorg.libXtst
    pkgs.xorg.libXi
  ];
  sourceRoot = "source";
  installPhase = ''
    mkdir -p $out
    cp -r . $out
    addAutoPatchelfSearchPath ./lib
  '';
}