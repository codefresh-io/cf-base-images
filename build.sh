#!/usr/local/bin/bash
set -e

TAG=$1

[ -z "$TAG" ] && echo tag argument is required && exit 1

ORIGINAL_DIR="$PWD"

TMP_CF_API_PATH=/tmp/cf-api-clone

rm -rf $TMP_CF_API_PATH || true
git clone git@github.com:codefresh/cf-api.git $TMP_CF_API_PATH
cd $TMP_CF_API_PATH
git checkout $TAG

cd $ORIGINAL_DIR

CF_API_TARGET_DIR=/opt/codefresh/cf/cf-api
CF_BASE_IMAGES_TARGET_DIR=/opt/codefresh/cf/cf-base-images

MOUNT_DOCKER="-v /var/run/docker.sock:/var/run/docker.sock"
MOUNT_CF_API="-e CF_API=$CF_API_TARGET_DIR -v $TMP_CF_API_PATH:$CF_API_TARGET_DIR"
MOUNT_IMAGES="-e CF_BASE_IMAGES=$CF_BASE_IMAGES_TARGET_DIR -v $ORIGINAL_DIR:$CF_BASE_IMAGES_TARGET_DIR"
PASS_TAG="-e TAG=$TAG"
CMD="bash $CF_BASE_IMAGES_TARGET_DIR/build/start-in-docker"

IMAGE="codefresh/cf-base-images-builder:$TAG"

docker build -t $IMAGE ./build

docker run \
  $MOUNT_DOCKER \
  $MOUNT_CF_API \
  $MOUNT_IMAGES \
  $PASS_TAG \
  $IMAGE
  $CMD
