#!/bin/bash

set -e
. ./.env

# wget https://releases.starrocks.io/starrocks/StarRocks-${STARROCKS_VERSION}.tar.gz -O ./image/base/StarRocks-${STARROCKS_VERSION}.tar.gz

docker build \
    --build-arg STARROCKS_VERSION=${STARROCKS_VERSION} \
    --build-arg PRIORITY_NETWORKS=${PRIORITY_NETWORKS} \
    -t starrocks-base:$STARROCKS_VERSION \
    -f ./image/base/Dockerfile .
