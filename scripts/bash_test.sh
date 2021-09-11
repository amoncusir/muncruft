#!/usr/bin/env sh

DOCKER_CONTAINER=$(docker run -dit ubuntu:20.04)

docker exec -it "${DOCKER_CONTAINER}" bash -c "`cat user_data.sh`"
docker exec -it "${DOCKER_CONTAINER}" bash
