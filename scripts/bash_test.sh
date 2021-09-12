#!/usr/bin/env sh

SCRIPT_PATH="$1"

DOCKER_CONTAINER=$(docker run -dit -v /var/run/docker.sock:/var/run/docker.sock ubuntu:20.04)

docker exec -it "${DOCKER_CONTAINER}" bash -c "`cat $SCRIPT_PATH`"
docker exec -it "${DOCKER_CONTAINER}" bash
docker rm -f "${DOCKER_CONTAINER}"