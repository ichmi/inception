FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server mariadb-client
RUN mkdir -p /var/run/mysqld /var/lib/mysql
RUN chown -R mysql:mysql /var/run/mysqld /var/lib/mysql && chmod 777 /var/run/mysqld
RUN echo "\n[mariadb]\nbind-address=0.0.0.0\nport=3306\n" >> /etc/mysql/my.cnf

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

COPY conf/wp.sql /tmp/
COPY conf/setup.sh /tmp/
RUN chmod 777 /tmp/setup.sh && /tmp/setup.sh

EXPOSE 3306

CMD ["mysqld_safe"]
