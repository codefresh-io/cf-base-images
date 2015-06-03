FROM ubuntu:14.04

# Update aptitude with new repo and install software from updated repo
RUN \
  apt-get update \
  && apt-get install -y git

COPY ./start.sh /run/start.sh

VOLUME /src
CMD ["sh", "/run/start.sh"]
