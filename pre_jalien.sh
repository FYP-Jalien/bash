#!/bin/bash

jalien_setup_dir="/home/jananga/FYP/jalien-setup"
jalien_dir="/home/jananga/FYP/jalien"
compile_script="/home/jananga/FYP/jalien/compile.sh"

clone_if_not_exists() {
    local dir_name="$1"
    local git_repo="$2"
    
    if [ ! -d "$dir_name" ]; then
        git clone "$git_repo" "$dir_name"
    else
        echo "Directory $dir_name already exists, skipping cloning."
    fi
}


cd /home/jananga/FYP
clone_if_not_exists "$jalien_setup_dir" "https://gitlab.cern.ch/jalien/jalien-setup"
cd "$jalien_setup_dir"
sudo make all
echo "jalien-setup make all finished successfully."


clone_if_not_exists "$jalien_dir" "https://gitlab.cern.ch/jalien/jalien"
cd "$jalien_dir"
./compile.sh cs
echo "alien-cs.jar created successfully."
cd ..




