FROM gliderlabs/alpine

RUN apk --update add git

COPY ./start.sh /run/start.sh

VOLUME /src
CMD ["sh", "/run/start.sh"]
