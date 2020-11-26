#!/bin/bash

echo "starting jenkinsx-destroy.sh"
#pre-reqs
source "${CONTEXT_PATH}/jenkinsx-setup.sh"

#install
jx upgrade cli
jx uninstall --batch-mode=true