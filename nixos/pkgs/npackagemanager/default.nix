{ stdenv, yarn }:

stdenv.mkDerivation rec {
  name = "npackagemanager";
  phases = ["configurePhase" "installPhase"];
  configurePhase = ''
    export HOME=$PWD/yarn_home
  '';
  buildInputs = [ yarn ];
  propagatedBuildInputs = [ yarn ];
  installPhase = ''
    yarn add n
    ls -la $HOME/
    mv node_modules $out/
  '';
}
