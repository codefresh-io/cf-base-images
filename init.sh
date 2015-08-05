#!/usr/local/bin/bash
set -e

TAG=$1
MODULE=$2

[ -z "$TAG" ] && echo TAG environment variable is required && exit 1

CF_BUILDID=$(date)

[ -e "images/base-ide/build/Dockerfile" ] && rm images/base-ide/build/Dockerfile

echo generated UID is: "$CF_BUILDID"

sed \
  -e "s/\$TAG/$TAG/g" \
  -e "s/\$UID/$RANDOM/g" \
   < images/base-ide/build/Dockerfile.template > images/base-ide/build/Dockerfile



[ -e "images/base/build/Dockerfile.build" ] && rm images/base/build/Dockerfile.build
cp images/base/build/Dockerfile images/base/build/Dockerfile.build
cat >> images/base/build/Dockerfile.build << EOP
LABEL io.codefresh.repo.owner=codefresh-io \\
           io.codefresh.repo.name=$MODULE \\
           io.codefresh.repo.branch=$(git symbolic-ref -q --short HEAD || git describe --tags --exact-match) \\
           io.codefresh.repo.sha=$(git rev-parse HEAD)
EOP


[ -e "images/base-ide/build/Dockerfile.build" ] && rm images/base-ide/build/Dockerfile.build
cp images/base-ide/build/Dockerfile images/base-ide/build/Dockerfile.build
cat >> images/base-ide/build/Dockerfile.build << EOP
LABEL io.codefresh.repo.owner=codefresh-io \\
           io.codefresh.repo.name=$MODULE \\
           io.codefresh.repo.branch=$(git symbolic-ref -q --short HEAD || git describe --tags --exact-match) \\
           io.codefresh.repo.sha=$(git rev-parse HEAD)
EOP


[ -e "images/git-clone/build/Dockerfile.build" ] && rm images/git-clone/build/Dockerfile.build
cp images/git-clone/build/Dockerfile images/git-clone/build/Dockerfile.build
cat >> images/git-clone/build/Dockerfile.build << EOP
LABEL io.codefresh.repo.owner=codefresh-io \\
           io.codefresh.repo.name=$MODULE \\
           io.codefresh.repo.branch=$(git symbolic-ref -q --short HEAD || git describe --tags --exact-match) \\
           io.codefresh.repo.sha=$(git rev-parse HEAD)
EOP