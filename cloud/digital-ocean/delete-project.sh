#!/bin/bash
echo "starting /digital/auth.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"

doctl projects delete --name ndtech-k8s-project
doctl projects list