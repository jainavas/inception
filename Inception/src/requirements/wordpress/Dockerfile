FROM debian:11

RUN apt-get update && apt-get -y install \
    curl \
    php-fpm \
    php-mysqli \
    mariadb-client \
    && apt-get clean

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir -p /run/php && chmod 755 /run/php

COPY ./tools/wp.sh /usr/local/bin/wp.sh
RUN chmod +x /usr/local/bin/wp.sh

EXPOSE 9000

WORKDIR /var/www/html/

ENTRYPOINT [ "/usr/local/bin/wp.sh" ]
