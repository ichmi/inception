#!/bin/bash

if [ -f ./wp-config.php ]
then
	echo "! WordPress: Config already avaiable"
else
    sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/mariadb/g" wp-config-sample.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php

    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CACHE_KEY_SALT frosa-ma.42.fr --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
    wp redis enable --allow-root

	echo "+ WordPress: Initial config done successfully"
fi

exec $@
