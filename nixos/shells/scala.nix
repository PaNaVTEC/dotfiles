with import <nixpkgs> {};

mkShell {
  buildInputs = [
    scala ammonite sbt
  ];
}
