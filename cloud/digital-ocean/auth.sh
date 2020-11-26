#!/bin/bash
echo "starting /digital/auth.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"

doctl auth init -t $DIGITAL_OCEAN_INITIAL_TOKEN