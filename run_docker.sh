#!/bin/bash

success=false
while [ "$success" = false ]; do
    sudo docker-compose -f /home/jananga/FYP/SHARED_VOLUME/docker-compose.yml up
    if [ $? -eq 0 ]; then
        success=true
    else
        echo "Starting the docker containers failed. Retrying..."
        sleep 15
    fi
done