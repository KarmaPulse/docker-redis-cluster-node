#Version 1.0.0
FROM ubuntu:14.04
MAINTAINER Marco Sanchez <marco@kamikazelab.com>

ENV REFRESHED_AT 2015-09-18

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y tcl8.5
RUN apt-get install -y wget 

RUN wget http://download.redis.io/releases/redis-stable.tar.gz
RUN tar xzf redis-stable.tar.gz
RUN cd redis-stable && make && make test && make install

ENV REFRESHED_AT 2015-09-21
COPY conf/redis.conf /conf/
RUN mkdir -p /redis-stable/log/

VOLUME /conf/
VOLUME /redis-stable/log/
VOLUME /redis-stable/backups/

EXPOSE 6379
EXPOSE 16379

ENTRYPOINT ["redis-server", "/conf/redis.conf"]
