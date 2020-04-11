with import <nixpkgs> {};

mkShell {
  buildInputs = [
    haskellPackages.stack
    cabal2nix
  ];
}
