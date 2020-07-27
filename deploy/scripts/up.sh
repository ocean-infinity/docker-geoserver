#!/bin/bash
if [ -n "$1" ]; then
    TAG=${1}
else
    TAG='2.17.0'
fi
echo $TAG
export DOCKER_TAG=$TAG
cd /home/oi && sudo docker-compose up -d
