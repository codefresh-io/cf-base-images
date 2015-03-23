FROM codefresh/cf-base:develop

#lifecycle "install" step
  #contributed from service "ssh-key"
  RUN apt-get -q -y install ssh sshpass
  ADD resources/ssh-key/* /root/.ssh/
  RUN chmod 700 ~/.ssh/
  RUN chmod 600 ~/.ssh/*
  RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

  #contributed from service "git"
  RUN sudo apt-get -q -y install git
  RUN mkdir -p /opt/codefresh/cf-ide
  WORKDIR /opt/codefresh/cf-ide/..

  RUN echo build 23-03-2015 15:25:00

  RUN git clone git@github.com:codefresh/orionPlugins.git cf-ide
  WORKDIR /opt/codefresh/cf-ide
  RUN git checkout orion-v8

  #contributed from service "cf-ide"
  RUN mkdir -p /workdir
  WORKDIR /opt/codefresh/cf-ide/org.eclipse.orion.client/modules/orionode
  RUN npm install
  RUN grunt codefresh
  WORKDIR /opt/codefresh/cf-ide/orionexpress
  RUN npm install
  RUN grunt build

#lifecycle "config" step
  #contributed from service "port"
  EXPOSE 8081

  # default environment variables

ADD start.sh /opt/codefresh/
CMD bash /opt/codefresh/start.sh
