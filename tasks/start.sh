#!/bin/bash

set -e

source config/config.sh

execute() {
    local file="$1"
    chmod +x "$file"
    if [ "$2" = "terminal" ]; then
        gnome-terminal --tab --title "$3" -- bash -c "$file $SCRIPT_DIR/config/config.sh;"
    else
        "$file" "$SCRIPT_DIR/config/config.sh"
    fi
}

args=("$@")

executePre=false
executeShared=false
executeSync=true
executeJalien=true
executeOpt=true
remove=false

for arg in "${args[@]}"; do
    if [ "$arg" = "--pre" ]; then
        executePre=true
        executeShared=true
        executeSync=false
        remove=true
    elif [ "$arg" = "--shared" ]; then
        executeShared=true
        executeSync=false
        remove=true
    elif [ "$arg" = "--remove" ]; then
        remove=true
    fi
done

for arg in "${args[@]}"; do
    if [ "$arg" = "--no-sync" ]; then
        executeSync=false
    elif [ "$arg" = "--no-jalien" ]; then
        executeJalien=false
        executeOpt=false
    elif [ "$arg" = "--no-opt" ]; then
        executeOpt=false
    fi
done

if [ "$executePre" = true ]; then
    execute "$SCRIPT_DIR/tasks/pre_jalien.sh"
fi

if [ "$executeShared" = true ]; then
    execute "$SCRIPT_DIR/tasks/create_shared.sh"
fi

if [ "$executeSync" = true ]; then
    execute "$SCRIPT_DIR/tasks/create_jar.sh"
    execute "$SCRIPT_DIR/tasks/sync_jar.sh"
fi

if [ "$executeJalien" = true ]; then
    if [ "$remove" = true ]; then
        execute "$SCRIPT_DIR/tasks/jalien.sh" "remove"
    else
        execute "$SCRIPT_DIR/tasks/jalien.sh"
    fi
fi

if [ "$executeOpt" = true ]; then
    execute "$SCRIPT_DIR/tasks/start_opt.sh" "terminal" "Optimiser"
fi


