#!/bin/bash

set -e

source ../config/config.sh

execute() {
    local file="$1"
    chmod +x "$file"
    "$file" "$SCRIPT_DIR/config/config.sh"
}

execute "$SCRIPT_DIR/tasks/pre_jalien.sh"  

execute "$SCRIPT_DIR/tasks/create_shared.sh"

execute "$SCRIPT_DIR/tasks/sync_jar.sh"

execute "$SCRIPT_DIR/tasks/jalien.sh"



# if [ "$2" = "shared" ]; then
#     chmod +x start_shared.sh;
#     start_shared.sh; 
#     if ! start_shared.sh; then
#         echo "Creating the shared volume failed. Exiting..."
#         exit 1;
#     fi
# fi