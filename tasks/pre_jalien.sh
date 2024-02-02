#!/bin/bash

set -e

source $1

clone_if_not_exists() {
    local dir_name="$1"
    local git_repo="$2"
    if [ ! -d "$dir_name" ]; then
        git clone "$git_repo" "$dir_name"
        echo "$git_repo cloned to $dir_name."
    else
        echo "Directory $dir_name already exists, skipping cloning."
    fi
}


mkdir -p "$BASE_DIR" && cd "$BASE_DIR" || exit 1
clone_if_not_exists "$JALIEN_SETUP" "$JALIEN_SETUP_SOURCE"
cd "$JALIEN_SETUP" || exit 1
echo "Start building Docker images...."
# sudo make all
echo "All Docker images built succcessfully."
cd "$SCRIPT_DIR"

clone_if_not_exists "$JALIEN" "$JALIEN_SOURCE"
# "$SCRIPT_DIR/tasks/sync_jar.sh" "$SCRIPT_DIR/config/config.sh"


