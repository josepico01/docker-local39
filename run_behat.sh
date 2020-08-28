#!/bin/bash

MODULE=$1
FEATURE=$2
CONTAINER="$(docker-compose ps -q behat-runner)"

docker exec \
    -it \
    --user www-data \
    ${CONTAINER} \
    sh -c "/siteroot/vendor/bin/behat \
        --config /var/www/behatdata/behatrun/behat/behat.yml \
        /siteroot/${MODULE}/tests/behat/${FEATURE}.feature
    "