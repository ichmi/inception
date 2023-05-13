FROM debian:buster

RUN apt-get update
RUN apt-get install -y redis

RUN echo "\nbind 0.0.0.0\nport 6379\n" > /etc/redis/redis.conf

RUN mkdir /data && chown -R redis:redis /data

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]

