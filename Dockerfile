FROM ubuntu:14.04

RUN apt-get update && apt-get install -y curl git

#add ssh record on which ssh key to use
COPY ./.ssh/ /root/.ssh/

COPY ./start.sh /run/start.sh

VOLUME /src
CMD ["sh", "/run/start.sh"]