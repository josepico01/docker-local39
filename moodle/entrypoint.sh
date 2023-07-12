#!/bin/bash

if [[ ${HOST_TYPE} == Linux ]]; then
    LOCAL_IP=$(ip route show | awk '/default/ { print $3 }')
else
    LOCAL_IP=docker.for.mac.localhost
fi

echo -e "\nxdebug.idekey=${IDE_KEY} \
\nxdebug.remote_host=${LOCAL_IP}" >> /etc/php/8.1/mods-available/xdebug.ini

echo -e "\n127.0.0.1\t${SITE_DOMAIN}" >> /etc/hosts

sed -i "s/##LISTENING_PORT##/${LISTENING_PORT}/" /etc/nginx/sites-available/default
sed -i "s/##SITE_DOMAIN##/${SITE_DOMAIN}/" /etc/nginx/sites-available/default

chown www-data:www-data /var/www

service php8.1-fpm start

exec "nginx"
