#!/bin/bash

set -e
. ./.env

#wget https://releases.starrocks.io/starrocks/StarRocks-${STARROCKS_VERSION}.tar.gz -O ./image/base/StarRocks-${STARROCKS_VERSION}.tar.gz

docker compose up -d --build 
sleep 10 
docker exec -it fe-server bash /opt/starrocks/setup_db.sh
