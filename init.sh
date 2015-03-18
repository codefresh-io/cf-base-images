#!/usr/local/bin/bash
set -e

TAG=$1

[ -z "$TAG" ] && echo TAG environment variable is required && exit 1

sed "s/\$TAG/$TAG/g" < images/base-ide/build/Dockerfile.template > images/base-ide/build/Dockerfile

