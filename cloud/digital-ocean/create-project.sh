#!/bin/bash
echo "starting /digital/create-project.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"

doctl projects create --name ndtech-k8s-project --purpose testing
doctl projects list