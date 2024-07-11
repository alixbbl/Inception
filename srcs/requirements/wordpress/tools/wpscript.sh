#!/bin/bash

# Attendre que les services se mettent en place
sleep 10

# Vérifier si le fichier wp-config.php existe déjà
if [ -f "/var/www/html/wp-config.php" ]
then
    echo "wordpress is already set !"
else
    echo "setting up wordpress"
    sleep 10

    # Créer le fichier wp-config.php avec wp-cli
    /usr/local/bin/wp-cli.phar config create --allow-root --dbname=$DB_DATABASE --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb:3306 --path='/var/www/html'

    # Modifier les permissions du fichier wp-config.php
    chmod 777 /var/www/html/wp-config.php

    # Changer le propriétaire du répertoire html
    chown -R root:root /var/www/html

    # Installer WordPress avec wp-cli
    /usr/local/bin/wp-cli.phar core install --allow-root --url=$DOMAIN_NAME --title="$SITE_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --path='/var/www/html'

    # Créer un nouvel utilisateur avec wp-cli
    /usr/local/bin/wp-cli.phar user create $WP_USER1_LOGIN $WP_USER1_MAIL --allow-root --role=author --user_pass=$WP_USER1_PASS --path='/var/www/html'

    echo "wordpress is running !"
fi

# Démarrer PHP-FPM
exec /usr/sbin/php-fpm7.4 -F;
