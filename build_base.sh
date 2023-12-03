#!/bin/bash

set -e

docker build \
    -t starrocks-base:2.5.16 \
    -f ./image/base/Dockerfile .