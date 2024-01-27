#!/bin/bash

source .env

# Remove the shared volume if it exists
if [ -d "$SHARED_VOLUME" ]; then
    rm -rf "$SHARED_VOLUME"
    echo "Directory $SHARED_VOLUME has been removed."
fi

# Creates the alien-cs.jar
chmod +x "$JALIEN/compile.sh"
"$JALIEN/compile.sh" cs
echo "alien-cs.jar created"

# Set the shared volume path
export SHARED_VOLUME=$SHARED_VOLUME

# Run the jared command with the specified JAR file and volume
"$JALIEN_SETUP/bin/jared" --jar "$JALIEN/alien-cs.jar" --volume "$SHARED_VOLUME"
echo "$SHARED_VOLUME created"


