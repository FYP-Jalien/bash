#!/bin/bash

source .env

if [ "$1" = "shared" ]; then
    chmod +x start_shared.sh;
    start_shared.sh; 
    if ! start_shared.sh; then
        echo "Creating the shared volume failed. Exiting..."
        exit 1;
    fi
fi

# Define an array of container names
containers=(
    "$CE_NAME"
    "$JCENTRAL_NAME"
    "$SCHEDD_NAME"
    "$SE_NAME"
    "$WORKER_NAME"
)

# Stop the containers
for container in "${containers[@]}"; do
    # Check if the container exists
    if sudo docker ps -a --format '{{.Names}}' | grep -q "$container"; then
        # If it exists, stop it
        sudo docker stop "$container"
        echo "Container $container stopped" 
    fi
done

# Remove the containers
for container in "${containers[@]}"; do
    # Check if the container exists
    if sudo docker ps -a --format '{{.Names}}' | grep -q "$container"; then
        # Remove the container
        sudo docker rm "$container"
        echo "Container $container removed"
    fi
done

chmod +x run_docker.sh;
gnome-terminal --tab --title DockerRunner -- bash -c 'run_docker.sh;';


is_container_running() {
    local container_name="$1"
    if sudo docker ps -q --filter "name=$container_name" | grep -q .; then
        return 0  
    else
        return 1 
    fi
}

while true; do
    all_containers_running=true
    
    for container_name in "${containers[@]}"; do
        if ! is_container_running "$container_name"; then
            all_containers_running=false
            break
        fi
    done

    if $all_containers_running; then
        echo "All containers are up and running."
        echo "Waiting 200 seconds until containers are finished setting up."
        # We need a reliable way to check whether the containers are up and running
        sleep 200
        break  
    else
        echo "Not all containers are up and running. Retrying..."
        sleep 15 
    fi
done

#chmod +x "$SHARED_VOLUME/optimiser.sh"
#gnome-terminal --tab --title Optimiser -- bash -c "$SHARED_VOLUME/optimiser.sh;""

#chmod +x start_alien.sh
#gnome-terminal --tab --title JobSubmissioner -- bash -c 'start_alien.sh;'

#gnome-terminal --tab --title Worker1  -- bash -c 'sudo docker exec -it $WORKER_NAME /bin/bash;'
#gnome-terminal --tab --title JCentral  -- bash -c 'sudo docker exec -it $JCENTRAL_NAME /bin/bash;'
#gnome-terminal --tab --title Schedd -- bash -c 'sudo docker exec -it $SCHEDD_NAME /bin/bash;'
#gnome-terminal --tab --title JCentral_CE  -- bash -c 'sudo docker exec -it $CE_NAME /bin/bash;'
#gnome-terminal --tab --title JCentral_SE  -- bash -c 'sudo docker exec -it $SE_NAME /bin/bash;'
