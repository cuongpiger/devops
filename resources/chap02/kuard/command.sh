#!/bin/bash

build_no_multistage() {
  docker build -t kuard-nomultistage -f Dockerfile.nomultistage .
}

build_multistage() {
  docker build -t kuard-multistage -f Dockerfile.multistage .
}

run_kuard_app() {
  docker run --rm -p 8000:8080 kuard-multistage
}

run_kuard_app_with_limited_resource() {
  docker run --rm -p 8000:8080 \
    --memory 200m \
    --memory-swap 1G \
    --cpu-shares 1024 \
    kuard-multistage
}

option="${1:-}"

case ${option} in
"build_no_multistage")
  build_no_multistage
  ;;
"build_multistage")
  build_multistage
  ;;
"run_kuard_app")
  run_kuard_app
  ;;
"run_kuard_app_with_limited_resource")
  run_kuard_app_with_limited_resource
  ;;
*)
  echo "Usage: command.sh [build_no_multistage|build_multistage]"
  ;;
esac