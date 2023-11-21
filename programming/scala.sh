#!/usr/bin/env bash

alias sbt='TERM=xterm-256colors sbt'

createProjectScala () {
  projectDirectory="$1"
  mkdir -p "$projectDirectory"
  sbt new scala/hello-world.g8 --name="$projectDirectory"
  echo 'libraryDependencies += "org.scalactic" %% "scalactic" % "3.0.1"' >> "$projectDirectory/build.sbt"
  echo 'libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.1" % "test"' >> "$projectDirectory/build.sbt"
  echo 'addSbtPlugin("org.scalastyle" %% "scalastyle-sbt-plugin" % "0.9.0")' >> "$projectDirectory/project/plugins.sbt"
  cd "$projectDirectory" || return
  sbt ensimeConfig
  sbt scalastyleGenerateConfig
}

cleanupMetalsProject() {
  rm -rf .bloop/ .bsp/ .idea/ .metals/ project/.bloop/ project/metals.sbt project/project/ project/target/ target/ service/target smithy/target lambda/target
}

killSbt() {
  killAllWithName sbt
}
