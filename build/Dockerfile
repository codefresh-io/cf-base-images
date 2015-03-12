FROM ubuntu:14.04

#install node
RUN \
  sudo apt-get -q -y update && \
  sudo apt-get -q -y install nodejs

#install docker
RUN \
  sudo apt-get -q -y update && \
  sudo apt-get install -q -y curl
RUN curl -sSL https://get.docker.com/ubuntu/ | sudo sh

#link node
RUN sudo ln -s "$(which nodejs)" /usr/bin/node

#stop docker daemon (we're going to mount the docker daemon soon, don't want collisions)
RUN \
  [ "$(service docker status | grep 'not running' || echo 'running')" == 'running' ] && \
  service docker stop
