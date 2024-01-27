#!/bin/bash

source .env

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


cd "$BASE_DIR" || exit 1
clone_if_not_exists "$JALIEN_SETUP" "$JALIEN_SETUP_SOURCE"
cd "$JALIEN_SETUP" || exit 1
sudo make all
echo "jalien-setup make all finished successfully."


clone_if_not_exists "$JALIEN" "$JALIEN_SOURCE"
cd "$JALIEN" || exit 1
./compile.sh cs
echo "alien-cs.jar created successfully."
cd ..




