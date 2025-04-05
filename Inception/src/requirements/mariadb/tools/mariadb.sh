#!/bin/bash
set -e

# Iniciar MariaDB en modo seguro en segundo plano
mysqld_safe --datadir=/var/lib/mysql &
# Esperar a que MariaDB esté disponible
until mysqladmin ping -h "127.0.0.1" --silent; do
    echo "Esperando a que MariaDB inicie..."
    sleep 2
done

# Inicializar la base de datos si aún no existe
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    mysql -u "${MYSQL_ROOT_USER}" -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
EOF
fi

# Apagar la instancia en segundo plano
mysqladmin -u "${MYSQL_ROOT_USER}" -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Iniciar MariaDB en primer plano para mantener el contenedor activo
exec mysqld --datadir=/var/lib/mysql --user=mysql

