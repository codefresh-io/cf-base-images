#!/usr/local/bin/bash
set -e

TAG=$1

[ -z "$TAG" ] && echo tag argument is required && exit 1

CF_BASE_IMAGES_TARGET_DIR=/opt/codefresh/cf/cf-base-images
CF_BASE_IMAGES_SOURCE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

CF_API_SOURCE_DIR=/tmp/cf-api-tmp
CF_API_TARGET_DIR=/opt/codefresh/cf/cf-api

MOUNT_DOCKER="-v /var/run/docker.sock:/var/run/docker.sock"
MOUNT_IMAGES="-e CF_BASE_IMAGES=$CF_BASE_IMAGES_TARGET_DIR -v $CF_BASE_IMAGES_SOURCE_DIR:$CF_BASE_IMAGES_TARGET_DIR"
MOUNT_CF_API="-e CF_API=$CF_API_TARGET_DIR -v $CF_API_SOURCE_DIR:$CF_API_TARGET_DIR"
PASS_TAG="-e TAG=$TAG"
CMD="bash -x $CF_BASE_IMAGES_TARGET_DIR/build/start-in-docker"
MOUNT_USERS="-v /etc/passwd:/etc/passwd"

IMAGE="codefresh/cf-base-images-builder"
TAGGED_IMAGE="$IMAGE:$TAG"

[ -e "$CF_API_SOURCE_DIR" ] && rm -rf $CF_API_SOURCE_DIR
git clone git@github.com:codefresh/cf-api.git $CF_API_SOURCE_DIR
cd $CF_API_SOURCE_DIR
git checkout $TAG

docker build -t $TAGGED_IMAGE $CF_BASE_IMAGES_SOURCE_DIR/build

docker run \
  --rm -it \
  $MOUNT_USERS \
  $MOUNT_DOCKER \
  $MOUNT_CF_API \
  $MOUNT_IMAGES \
  $PASS_TAG \
  $TAGGED_IMAGE \
  $CMD
