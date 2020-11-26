#!/bin/bash
echo "starting /digital/execute.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"

process-path() {

  if [[ "${NDTECH_K8S_MODE}" == "plan" ]]; then
    echo "planning resources for digital ocean k8s"

  elif [ "${NDTECH_K8S_MODE}" == "create-cluster" ]; then
    echo "creating resources for digital ocean k8s"
    source "${CONTEXT_PATH}/auth.sh"
    source "${CONTEXT_PATH}/create-cluster.sh"

  elif [ "${NDTECH_K8S_MODE}" == "destroy-cluster" ]; then
    echo "destroying resources for digital ocean k8s"
    source "${CONTEXT_PATH}/auth.sh"
    source "${CONTEXT_PATH}/destroy-cluster.sh"

  else
    echo "invalid NDTECH_K8S_MODE"

  fi
}

process-path
