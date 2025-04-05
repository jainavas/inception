#!/bin/bash

# Verificar si el archivo wp-config.php ya existe
if [ -f /var/www/html/wp-config.php ]; then
    echo "Wordpress already exists"
else
    # Descargar WordPress si no está presente
    wp core download --allow-root

    # Crear el archivo wp-config.php
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root

    # Instalar WordPress
    wp core install --url=$DONAIN_NAME --title="$WORDPRESS_TITLE" --admin_user=$WORDPRESS_ADMIM --admin_password=$WORDPRESS_ADMIM_PASS --admin_email=$WORDPRESS_ADMIM_EMAIL --skip-email --allow-root

    # Crear el usuario de WordPress
    wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASS --allow-root

    # Instalar y activar el tema
    wp theme install twentysixteen --activate --allow-root
fi

# Ejecutar PHP-FPM
/usr/sbin/php-fpm7.4 -F;

