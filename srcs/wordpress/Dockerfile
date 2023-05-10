FROM debian:buster

WORKDIR /var/www/html

RUN apt-get update && apt-get upgrade -y && apt-get install -y curl
RUN curl -O https://wordpress.org/latest.tar.gz
RUN tar xvf latest.tar.gz && mv wordpress/* . && rm -rf wordpress latest.tar.gz
RUN chown -R www-data:www-data /var/www/html && chmod -R 777 /var/www/html

RUN mkdir -p /run/php && chmod 777 /var/run/php
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql
RUN sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/g" /etc/php/7.3/fpm/pool.d/www.conf

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_DATABASE

COPY conf/setup.sh /tmp/
RUN chmod 777 /tmp/setup.sh && /tmp/setup.sh

EXPOSE 9000

CMD ["php-fpm7.3", "-F"]
