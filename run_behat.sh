#!/bin/bash

MODULE=$1
FEATURE=$2

docker exec \
    -it \
    --user www-data \
    $(docker-compose -f behat-runner/docker-compose.yml ps -q behat-runner) \
    sh -c "/siteroot/vendor/bin/behat \
        --config /var/www/behatdata/behatrun/behat/behat.yml \
        /siteroot/${MODULE}/tests/behat/${FEATURE}.feature
    "