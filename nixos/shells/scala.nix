with import <nixpkgs> {};

mkShell {
  name = "Scala 3";
  buildInputs = [
    dotty sbt sbt-extras figlet
  ];
  shellHook = ''
    figlet "Scala"
    echo "$(scala --version)"
    cd ~/dotfiles/nixos/shells/
    sbt console
  '';
}
