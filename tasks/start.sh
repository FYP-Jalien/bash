#!/bin/bash

set -e

source ../config/config.sh

execute() {
    local file="$1"
    chmod +x "$file"
    if [ "$2" = "terminal" ]; then
        gnome-terminal --tab --title ContainrLogs -- bash -c "$file $SCRIPT_DIR/config/config.sh;"
    else
        "$file" "$SCRIPT_DIR/config/config.sh"
    fi
}


execute "$SCRIPT_DIR/tasks/pre_jalien.sh"  

execute "$SCRIPT_DIR/tasks/create_shared.sh"

execute "$SCRIPT_DIR/tasks/sync_jar.sh"

execute "$SCRIPT_DIR/tasks/jalien.sh"

execute "$SCRIPT_DIR/tasks/start_opt.sh" "terminal"
