#!/bin/bash -e

projectCreateJava () {
  gradle init --type java-library
  sed '$itestCompile "org.mockito:mockito-all:1.10.19"' build.gradle >> build.gradle
  gradle --refresh-dependencies
}
