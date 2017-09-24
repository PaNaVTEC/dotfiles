#!/bin/bash -e

docker_stop_all() {
  docker stop $(docker ps -a -q)
}

docker_prune() {
  docker system prune
  docker rmi $(docker images -a -q)
}
