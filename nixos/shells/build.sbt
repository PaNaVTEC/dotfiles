name := "Scala Playground"

version := "1.0"

scalaVersion := "3.1.3"

libraryDependencies += "org.typelevel" %% "cats-core" % "2.7.0"
libraryDependencies += "org.typelevel" %% "cats-effect" % "3.3.12"
libraryDependencies += "org.typelevel" %% "cats-effect-laws" % "3.3.12" % Test

// console / initialCommands += Seq(
//   "import cats._",
//   "import cats.effect._"
// ).fold("")((a, b) => a + ", " + b)

console / initialCommands += """
import cats._
import cats.effect._
"""
