#!/bin/bash

wget_if_not_exists() {
    local local_name="$2"
    local drive_link="$1"
    
    if [ ! -f "$local_name" ]; then
    	wget --no-check-certificate $drive_link -O $local_name 
        echo "$drive_link is downloaded to $local_name"
    else
        echo "File $local_name already exists, skipping downloading."
    fi
}

wget_if_not_exists "https://drive.google.com/uc?export=download&id=1NTFutMlpFxwB6wzHdxJP4K96p9oB1HSx" "/home/jananga/FYP/alma-alienv"
wget_if_not_exists "https://drive.google.com/uc?export=download&id=1KUsBgUt8Qd0X0ciK6aH5k3zqq8KfLpPQ" "/home/jananga/FYP/sample.jdl"
wget_if_not_exists "https://drive.google.com/uc?export=download&id=10KUfWm4mjIkmcgndlyHJJDRdxqn2_tg5" "/home/jananga/FYP/testscript.sh"

chmod +x /home/jananga/FYP/my_bash/check_status.sh;
gnome-terminal --tab --title StatusChecker -- bash -c '/home/jananga/FYP/my_bash/check_status.sh;'
chmod +x /home/jananga/FYP/alma-alienv
source /home/jananga/FYP/alma-alienv setenv xjalienfs

source /home/jananga/FYP/SHARED_VOLUME/env_setup.sh

alien.py cp file:///home/jananga/FYP/sample.jdl alien://sample.jdl
alien.py cp file:///home/jananga/FYP/testscript.sh alien://

echo "Files submitted succesfully"

while true; do
    read -rp "Press Enter to submit a job (or Ctrl+C to exit): " response
    if [[ "$response" == "" ]]; then
        alien.py submit ./sample.jdl
    else
        echo "Waiting for Enter key to submit a job..."
    fi
done






