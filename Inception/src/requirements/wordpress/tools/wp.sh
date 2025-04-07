#!/bin/bash

# Poner la url en hosts
DOMAIN=${DONAIN_NAME:-$1}
IP=${2:-127.0.0.1}

if [ -z "$DOMAIN" ]; then
    echo "DONAIN_NAME not found";
    exit 1
fi

if grep -q "$DOMAIN" /etc/hosts; then
    echo "Domain already present on etc/hosts";
else
    echo "$IP  $DOMAIN" | sudo tee -a /etc/hosts > /dev/null
    echo "Domain added to etc/hosts";
fi

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

