#!/bin/bash

source ../../config/config.sh

container_names=( "$SCHEDD_NAME" "$JCENTRAL_NAME" "$SE_NAME" "$CE_NAME" "$WORKER_NAME"  )

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
        break  
    else
        echo "Not all containers are up and running. Retrying..."
        sleep 15 
    fi
done



gnome-terminal --tab --title Worker1  -- bash -c 'sudo docker exec -it shared_volume_worker1_1 /bin/bash;'
gnome-terminal --tab --title JCentral  -- bash -c 'sudo docker exec -it shared_volume_JCentral-dev_1 /bin/bash;'
gnome-terminal --tab --title Schedd -- bash -c 'sudo docker exec -it shared_volume_schedd_1 /bin/bash;'
gnome-terminal --tab --title JCentral_CE  -- bash -c 'sudo docker exec -it shared_volume_JCentral-dev-CE_1 /bin/bash;'
gnome-terminal --tab --title JCentral_SE  -- bash -c 'sudo docker exec -it shared_volume_JCentral-dev-SE_1 /bin/bash;'
