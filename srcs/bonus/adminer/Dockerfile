FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php7.3-json php7.3-phar wget

RUN mkdir -p /run/php

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

RUN mkdir -p /var/www/html && mv ./adminer-4.8.1.php /var/www/html/index.php

RUN echo "\nlisten = 0.0.0.0:9000" >> /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["php-fpm7.3", "-F"]
