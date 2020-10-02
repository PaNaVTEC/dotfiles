with import <nixpkgs> {};

mkShell {
  buildInputs = [
    nodejs-12_x
    (yarn.override { nodejs = nodejs-12_x; })
    nodePackages.tern
    nodePackages.node2nix
    nodePackages.lerna
    cypress
  ];
}
