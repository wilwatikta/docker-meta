FROM ubuntu:latest

RUN apt -y update \
    && apt -y install g++ git cmake make libjemalloc-dev zlib1g-dev gnupg gnupg2 \
    && apt -y --no-install-recommends install ca-certificates curl

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN mkdir -p /home/user
RUN chown user /home/user
RUN chgrp user /home/user

COPY docker-entrypoint.sh /
COPY compile-meta.sh /home/user

ENTRYPOINT ["/docker-entrypoint.sh"]