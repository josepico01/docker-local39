#!/bin/bash

LOCAL_IP=$(ip route show | awk '/default/ { print $3 }')

echo -e "\nxdebug.idekey=${IDE_KEY} \
\nxdebug.remote_host=${LOCAL_IP}" >> /etc/php/7.2/mods-available/xdebug.ini

echo -e "\n127.0.0.1\t${SITE_DOMAIN}" >> /etc/hosts

sed -i "s/##LISTENING_PORT##/${LISTENING_PORT}/" /etc/nginx/sites-available/default
sed -i "s/##SITE_DOMAIN##/${SITE_DOMAIN}/" /etc/nginx/sites-available/default

# let the eass/dbs all start up first before initialising the behat test suite
sleep 5

# initialise the behat stuff
php /siteroot/admin/tool/behat/cli/init.php

# chown the behat data dirs
for d in behatdata behatfaildumps; do
    chown -R www-data:www-data /var/www/$d
done

# start up php-fpm
service php7.2-fpm start

exec "nginx"