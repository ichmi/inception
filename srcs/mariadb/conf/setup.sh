#!/bin/bash

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ];
then
	echo "! MariaDB: Database $MYSQL_DATABASE already exists"
else
    mysqld_safe &
    service mysql start

    mysql -e "DROP USER IF EXISTS ''@'localhost';"
    mysql -e "DROP DATABASE IF EXISTS test;"

    mysql -e "CREATE DATABASE $MYSQL_DATABASE;"
    mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%';"

    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';FLUSH PRIVILEGES;"

    mysql -uroot -p$MYSQL_ROOT_PASSWORD -hlocalhost $MYSQL_DATABASE < /tmp/wp.sql

	echo "+ MariaDB: Database $MYSQL_DATABASE created"
fi
