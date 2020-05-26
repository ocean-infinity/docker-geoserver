#!/bin/bash
if [ -n "$1" ]; then
    TAG=${1}
else
    TAG='2.17.0'
fi
export $(cat /root/.env | xargs)
export DOCKER_TAG=$TAG
docker pull oinf/geoserver:$TAG
docker-compose down --remove-orphans
