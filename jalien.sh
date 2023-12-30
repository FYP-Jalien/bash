#!/bin/bash

if [ "$1" = "shared" ]; then
    chmod +x /home/jananga/FYP/my_bash/start_shared.sh;
    /home/jananga/FYP/my_bash/start_shared.sh; 
    if [ $? -ne 0 ]; then
        echo "Creating the shared volume failed. Exiting..."
        exit 1;
    fi
fi

# Define an array of container names
containers=(
    "shared_volume_JCentral-dev-CE_1"
    "shared_volume_JCentral-dev-SE_1"
    "shared_volume_JCentral-dev_1"
    "shared_volume_worker1_1"
    "shared_volume_schedd_1"
)

# Stop the containers
container_exits=false;
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

chmod +x /home/jananga/FYP/my_bash/run_docker.sh;
gnome-terminal --tab --title DockerRunner -- bash -c '/home/jananga/FYP/my_bash/run_docker.sh;';

container_names=("shared_volume_JCentral-dev_1" "shared_volume_JCentral-dev-SE_1" "shared_volume_schedd_1" "shared_volume_worker1_1" "shared_volume_JCentral-dev-CE_1")

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
    
    for container_name in "${container_names[@]}"; do
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

#chmod +x /home/jananga/FYP/SHARED_VOLUME/optimiser.sh
#gnome-terminal --tab --title Optimiser -- bash -c '/home/jananga/FYP/SHARED_VOLUME/optimiser.sh;'

#chmod +x /home/jananga/FYP/my_bash/start_alien.sh
#gnome-terminal --tab --title JobSubmissioner -- bash -c '/home/jananga/FYP/my_bash/start_alien.sh;'

#gnome-terminal --tab --title Worker1  -- bash -c 'sudo docker exec -it shared_volume_worker1_1 /bin/bash;'
#gnome-terminal --tab --title JCentral  -- bash -c 'sudo docker exec -it shared_volume_JCentral-dev_1 /bin/bash;'
#gnome-terminal --tab --title Schedd -- bash -c 'sudo docker exec -it shared_volume_schedd_1 /bin/bash;'
#gnome-terminal --tab --title JCentral_CE  -- bash -c 'sudo docker exec -it shared_volume_JCentral-dev-CE_1 /bin/bash;'
#gnome-terminal --tab --title JCentral_SE  -- bash -c 'sudo docker exec -it shared_volume_JCentral-dev-SE_1 /bin/bash;'
