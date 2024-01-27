#!/bin/bash

source .env

success=false
while [ "$success" = false ]; do
    if sudo docker-compose -f "$SHARED_VOLUME/docker-compose.yml" up; then
        success=true
    else
        echo "Starting the docker containers failed. Retrying..."
        sleep 15
    fi
done