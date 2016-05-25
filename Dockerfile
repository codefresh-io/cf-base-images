FROM alpine:latest

RUN apk add --update git curl

#add ssh record on which ssh key to use
COPY ./.ssh/ /root/.ssh/

COPY ./start.sh /run/start.sh

CMD ["sh", "/run/start.sh"]