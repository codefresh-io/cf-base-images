FROM gliderlabs/alpine

RUN apk --update add git openssh sshpass

#add ssh record on which ssh key to use
COPY ./.ssh/ /root/.ssh/

COPY ./start.sh /run/start.sh

VOLUME /src
CMD ["sh", "/run/start.sh"]
