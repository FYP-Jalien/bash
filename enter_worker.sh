#!/bin/bash

source .env

sudo docker exec -it "$WORKER_NAME" /bin/bash 
