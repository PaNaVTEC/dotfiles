with import <nixpkgs> {};

mkShell {
  buildInputs = [
    haskellPackages.stack
  ];
}
