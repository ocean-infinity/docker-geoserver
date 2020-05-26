#!/bin/bash
if [ -n "$1" ]; then
    TAG=${1}
else
    TAG='2.17.0'
fi
export DOCKER_TAG=$TAG
cd /root && docker-compose up -d
