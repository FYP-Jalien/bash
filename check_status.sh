#!/bin/bash

source enter_alien.sh

while true; do
    echo "The status of the jobs"
    alien.py ps
    echo "================================================"
    sleep 10
done