FROM ubuntu:14.04

#install node
RUN \
  sudo apt-get -q -y update && \
  sudo apt-get -q -y install nodejs npm
RUN sudo ln -s "$(which nodejs)" /usr/bin/node
RUN sudo npm install -g npm
RUN sudo npm install -g grunt-cli

#install docker
RUN \
  sudo apt-get -q -y update && \
  sudo apt-get install -q -y curl
RUN curl -sSL https://get.docker.com/ubuntu/ | sudo sh

#adapt bash to our conventions...
RUN sudo ln -s "$(which bash)" /usr/local/bin/bash

