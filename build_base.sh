#!/bin/bash

set -e

docker build \
    -t starrocks-base:3.1.6 \
    -f ./image/base/Dockerfile .