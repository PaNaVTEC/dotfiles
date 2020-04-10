with import <nixpkgs> {};

mkShell {
  buildInputs = [
    nodejs
    yarn
    nodePackages.tern
    sass
    nodePackages.grunt-cli
  ];
}
