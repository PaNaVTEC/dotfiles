with import <unstable> {}; {
  java-env = stdenv.mkDerivation {
    name = "java-env";
    JAVA_HOME = "${pkgs.openjdk16-bootstrap.home}";
    buildInputs = [
      openjdk16-bootstrap
    ];
  };
}
