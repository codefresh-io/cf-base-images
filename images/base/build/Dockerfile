FROM ubuntu:14.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh


#contributed from service "apt"
  RUN sudo apt-get update
  RUN sudo apt-get -q -y install git ssh sshpass curl build-essential


# Install nvm with node, iojs and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash \
    && source /root/.nvm/nvm.sh \
    && nvm install stable \
    && nvm alias node stable \
    && nvm install iojs stable \
    && nvm alias iojs stable \
    && nvm use node

ENV PATH /root/.nvm/versions/node/v0.12.2/bin:$PATH

RUN npm install -g bower grunt-cli
RUN apt-get -q -y install ruby
RUN gem install sass