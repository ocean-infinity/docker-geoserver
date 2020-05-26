#!/bin/bash
if [ -n "$1" ]; then
    TAG=${1}
else
    TAG='2.17.0'
fi

this_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
parent_dir=$(dirname $this_dir)
TARGET='root@geo-uk1.oi-dev.com' # the server we're deploying to

scp -o "StrictHostKeyChecking=no" Caddyfile .env .bashrc docker-compose.yml ${TARGET}:/root/
ssh -o "StrictHostKeyChecking=no" ${TARGET} 'bash -s' < ${parent_dir}/scripts/pull_and_stop.sh $TAG
ssh -o "StrictHostKeyChecking=no" ${TARGET} 'bash -s' < ${parent_dir}/scripts/up.sh $TAG
