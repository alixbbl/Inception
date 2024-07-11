#!/bin/sh

if [ -d "/var/lib/mysql/${DB_DATABASE}" ]
then
    echo "==> database ${DB_DATABASE} already exists\n"
else
    echo "starting mariadb..."
    service mariadb start
    sleep 1
    echo "creating database: ${DB_DATABASE}"
    mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
    mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
    sleep 1
    # shutting down mariadb so it can be restarted using exec
    mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown
fi
sleep 1
# using exec, the specified command becomes PID 1
# runs the command without a shell. It can have advantages in term of signal handling and clean process termination
exec mysqld
