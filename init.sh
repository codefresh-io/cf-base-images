#!/usr/local/bin/bash
set -e

TAG=$1

[ -z "$TAG" ] && echo TAG environment variable is required && exit 1

RANDOM=$(uuidgen)

sed \
  -e "s/\$TAG/$TAG/g" \
  -e "s/\$UID/$RANDOM/g" \
   < images/base-ide/build/Dockerfile.template > images/base-ide/build/Dockerfile

