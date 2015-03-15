#!/usr/local/bin/bash
set -e

TAG=$1

[ -z "$TAG" ] && echo TAG environment variable is required && exit 1

CF_BASE_EXISTS=$(docker images | awk '{print $1,":",$2}' | tr -d "[:blank:]" | grep "codefresh/cf-base:$TAG" || echo)
[ "$CF_BASE_EXISTS" ] && docker rmi codefresh/cf-base:$TAG
docker build -t codefresh/cf-base:$TAG ./images/base/build

CF_BASE_IDE_EXISTS=$(docker images | awk '{print $1,":",$2}' | tr -d "[:blank:]" | grep "codefresh/cf-base-ide:$TAG" || echo)
[ "$CF_BASE_IDE_EXISTS" ] && docker rmi codefresh/cf-base-ide:$TAG
docker build -t codefresh/cf-base-ide:$TAG ./images/base-ide/build

