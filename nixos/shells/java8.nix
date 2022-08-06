with import <unstable> {}; {
  java-env = stdenv.mkDerivation {
    name = "java-env";
    JAVA_HOME = "${pkgs.jdk8.home}";
    buildInputs = [
      jetbrains.idea-community
      figlet
      jdk8
    ];
    shellHook = ''
      figlet "Java 8"
      java -version
      echo "java home: ${pkgs.jdk8.home}"
      idea-community
    '';
  };
}
