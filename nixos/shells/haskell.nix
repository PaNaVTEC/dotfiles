with import <nixpkgs> {};

mkShell {
  buildInputs = [
    figlet

    haskellPackages.stack
#    haskellPackages.haskell-language-server
#    haskellPackages.fourmolu_0_3_0_0
    cabal2nix
  ];
  name = "Haskell";
  shellHook = ''
    figlet "Haskell"
    echo "Stack version: $(stack --version)"
    ghc --version
  '';
}
