#!/usr/local/bin/bash
set -e

TAG=$1

[ -z "$TAG" ] && echo TAG environment variable is required && exit 1

CF_BUILDID=$(date)

[ -e "images/base-ide/build/Dockerfile" ] && rm images/base-ide/build/Dockerfile

echo generated UID is: "$CF_BUILDID"

sed \
  -e "s/\$TAG/$TAG/g" \
  -e "s/\$UID/$RANDOM/g" \
   < images/base-ide/build/Dockerfile.template > images/base-ide/build/Dockerfile

