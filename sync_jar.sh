#!/bin/bash

source .env

chmod +x "$JALIEN/compile.sh"
"$JALIEN/compile.sh" cs
echo "alien-cs.jar created"
