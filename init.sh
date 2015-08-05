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


#inject IDE to correct place where cf-base-ide expects it to be
mkdir -p tmp
cd tmp
if [ -e "cf-ide/.git" ] ; then \
  cd cf-ide
  git pull
  git checkout develop
  git merge origin/develop
else
  git clone git@github.com:codefresh/orionPlugins.git cf-ide
  cd cf-ide
  git checkout develop
fi

#this line was in start.sh, copying it here now because:
#1. we no longer have git files inside the base-ide container.
#2. this probably slows boot time a bit.
#3. it makes the code of orion-plugins unpredictable across containers - we don't know what's running because it pulls changes
#4. this code ran after npm install/bower install etc, which doesn't make sense to me.
git pull origin orion-v8

mkdir -p ../../images/base-ide/build/resources/cf-ide
git archive develop | tar -x -C ../../images/base-ide/build/resources/cf-ide

