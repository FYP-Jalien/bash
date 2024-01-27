#!/bin/bash

source .env

chmod +x "$ALIENV"
source "$ALIENV" setenv xjalienfs

source "$SHARED_VOLUME/env_setup.sh"

