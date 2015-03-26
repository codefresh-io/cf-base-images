FROM ubuntu:14.04

  #lifecycle "install" step
  #contributed from service "apt"
  RUN sudo apt-get update
  RUN sudo apt-get -q -y install git ssh sshpass

  #contributed from service "nodejs"
  RUN sudo apt-get -q -y install nodejs npm
  RUN sudo ln -s "$(which nodejs)" /usr/bin/node
  RUN npm install -g npm bower grunt-cli

  #contributed from service "ruby"
  RUN apt-get -q -y install ruby

  #contributed from service "sass"
  RUN gem install sass

  # default environment variables

#install java
RUN apt-get update && \
  sudo apt-get install -q -y python-software-properties software-properties-common && \
  add-apt-repository --yes ppa:webupd8team/java && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

RUN apt-get update && \
  apt-get install -q -y oracle-java8-installer && \
  apt-get install oracle-java8-set-default

#install cassandra
RUN echo deb http://www.apache.org/dist/cassandra/debian 20x main > /etc/apt/sources.list.d/cassandra.list && \
  echo deb-src http://www.apache.org/dist/cassandra/debian 20x main >> /etc/apt/sources.list.d/cassandra.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 2B5C1B00 0353B12C F758CE318D77295D && \
  apt-get update && \
  apt-get install -q -y cassandra

