#!/bin/bash

source ../config/config.sh

# chmod +x check_status.sh;
# gnome-terminal --tab --title StatusChecker -- bash -c 'check_status.sh;'
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






