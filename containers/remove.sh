#!/bin/bash

source "$1"

containers=(
    "$CE_NAME"
    "$JCENTRAL_NAME"
    "$SCHEDD_NAME"
    "$SE_NAME"
    "$WORKER_NAME"
)

is_container_exists() {
    local container_name="$1"
    if sudo docker ps -a -q -f name="$container_name" | grep -q .; then
        return 1
    else
        return 0
    fi
}

# Remove the containers
for container in "${containers[@]}"; do
    if is_container_exists "$container_name"; then
        sudo docker rm "$container"
        echo "Container $container removed"
    fi
done