#!/bin/bash

CLASS=$1
PHPTEST=$2

docker exec \
    -it \
    --user www-data \
    $(docker-compose -f moodle/docker-compose.yml ps -q eass) \
    sh -c "php /siteroot/vendor/bin/phpunit ${CLASS} /siteroot/${PHPTEST}"
