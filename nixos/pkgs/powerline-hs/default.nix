{ stdenv , pkgs, fetchFromGitHub , ... }:

stdenv.mkDerivation rec {
  name = "powerline-hs";
  src = fetchFromGitHub {
    owner = "rdnetto";
    repo = "powerline-hs";
    rev = "4253967";
    sha256 = "0lr6qcms8pqhbg1ig8a2f1zzhmg3wls86afzpk7y2hbpmlwhisbj";
  };
  buildInputs = [pkgs.cabal-install];
  installPhase = ''
    pwd
    ls -la
    cabal build
  '';
}
