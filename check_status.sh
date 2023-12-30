#!/bin/bash

chmod +x /home/jananga/FYP/alma-alienv
source /home/jananga/FYP/alma-alienv setenv xjalienfs

source /home/jananga/FYP/SHARED_VOLUME/env_setup.sh

while true; do
    echo "The status of the jobs"
    alien.py ps
    echo "================================================"
    sleep 10
done