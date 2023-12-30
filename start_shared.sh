#!/bin/bash



# Remove the shared volume if it exists
shared_volume_directory="/home/jananga/FYP/SHARED_VOLUME"
if [ -d "$shared_volume_directory" ]; then
    rm -rf "$shared_volume_directory"
    echo "Directory$shared_volume_directory has been removed."
fi

# Creates the alien-cs.jar
chmod +x /home/jananga/FYP/jalien/compile.sh
/home/jananga/FYP/jalien/compile.sh cs
echo "alien-cs.jar created"

# Set the shared volume path
export SHARED_VOLUME=/home/jananga/FYP/SHARED_VOLUME

# Run the jared command with the specified JAR file and volume
/home/jananga/FYP/jalien-setup/bin/jared --jar /home/jananga/FYP/jalien/alien-cs.jar --volume $SHARED_VOLUME
echo "$SHARED_VOLUME created"


