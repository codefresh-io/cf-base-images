FROM ubuntu:14.04

# install dependencies
RUN apt-get update && apt-get install -y \
      curl \
      npm \
      nodejs \
      git \
      ssh \
      sshpass;

# compatibility fix for node on ubuntu
RUN ln -s /usr/bin/nodejs /usr/bin/node;

# install nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | sh;

# invoke nvm to install node
RUN cp -f ~/.nvm/nvm.sh ~/.nvm/nvm-tmp.sh; \
    echo "nvm install stable; nvm alias node stable; nvm install iojs stable; nvm alias iojs stable" >> ~/.nvm/nvm-tmp.sh; \
    sh ~/.nvm/nvm-tmp.sh; \
    rm ~/.nvm/nvm-tmp.sh;

ENV PATH /root/.nvm/versions/node/v0.12.2/bin:$PATH

RUN npm install -g bower
RUN npm install -g grunt-cli
RUN apt-get -q -y install ruby
RUN gem install sass