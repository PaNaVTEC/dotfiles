with import <nixpkgs> {};

mkShell {
  buildInputs = [
    figlet

    haskellPackages.stack
    cabal2nix
  ];
  name = "Haskell";
  shellHook = ''
    figlet "Haskell"
    echo "Stack version: $(stack --version)"
    ghc --version
  '';
}
