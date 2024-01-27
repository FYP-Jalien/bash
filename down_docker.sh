#!/bin/bash

source .env

sudo docker-compose -f "$SHARED_VOLUME/docker-compose.yml" down

