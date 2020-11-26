#!/bin/bash
echo "starting /digital/k8s-config.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"

doctl kubernetes cluster kubeconfig save ndtech-k8s-cluster