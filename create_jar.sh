#!/bin/bash

source .env

chmod +x "$JALIEN/compile.sh"
"$JALIEN/compile.sh" cs
echo "alien-cs.jar created"

cp "$JALIEN/alien-cs.jar" "$SHARED_VOLUME/"
echo "alien-cs.jar copied to $SHARED_VOLUME/"
