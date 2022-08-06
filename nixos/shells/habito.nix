with import <nixpkgs> {};

mkShell {
  buildInputs = [
    haskellPackages.stack
    cabal2nix
    nodejs-12_x
    (yarn.override { nodejs = nodejs-12_x; })
    nodePackages.tern
    nodePackages.node2nix
    nodePackages.lerna
    cypress
    shellcheck
  ];
}
