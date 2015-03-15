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

RUN echo build 5194770a-f7df-4266-9484-c4d03c3e21c1
