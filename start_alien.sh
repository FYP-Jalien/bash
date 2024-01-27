#!/bin/bash

source .env

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

wget_if_not_exists "$ALMA_ALIENV_SOURCE" "$ALIENV"
wget_if_not_exists "$SAMPLE_JDL_SOURCE" "$SAMPLE_JDL"
wget_if_not_exists "$TESTSCRIPT_SOURCE" "$TESTSCRIPT"

chmod +x check_status.sh;
gnome-terminal --tab --title StatusChecker -- bash -c 'check_status.sh;'
chmod +x "$ALIENV"
source "$ALIENV" setenv xjalienfs

source "$SHARED_VOLUME/env_setup.sh"

alien.py cp file://"$SAMPLE_JDL" alien://sample.jdl
alien.py cp file://"$TESTSCRIPT" alien://

echo "Files submitted succesfully"

while true; do
    read -rp "Press Enter to submit a job (or Ctrl+C to exit): " response
    if [[ "$response" == "" ]]; then
        alien.py submit ./sample.jdl
    else
        echo "Waiting for Enter key to submit a job..."
    fi
done






