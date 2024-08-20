#!/bin/bash

set -e
. ./.env

if ! test -f ./image/base/StarRocks-${STARROCKS_VERSION}.tar.gz; then
  echo "StarRocks-${STARROCKS_VERSION}.tar.gz does not exists"

  wget https://releases.starrocks.io/starrocks/StarRocks-${STARROCKS_VERSION}.tar.gz -O ./image/base/StarRocks-${STARROCKS_VERSION}.tar.gz
fi

docker compose up -d --build 
sleep 15 
docker exec -it fe-server bash /opt/starrocks/setup_db.sh
