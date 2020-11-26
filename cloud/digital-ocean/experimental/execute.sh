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

  elif [ "${NDTECH_K8S_MODE}" == "create-jenkinsx" ]; then
    echo "creating jenkins x resources for digital ocean k8s"
    source "${CONTEXT_PATH}/create-jenkinsx.sh"

  elif [ "${NDTECH_K8S_MODE}" == "destroy-jenkinsx" ]; then
    echo "destroying resources for digital ocean k8s"
    source "${CONTEXT_PATH}/destroy-jenkinsx.sh"

  elif [ "${NDTECH_K8S_MODE}" == "create-jenkinsx3" ]; then
    echo "creating jenkins x resources for digital ocean k8s"
    source "${CONTEXT_PATH}/create-jenkinsx3.sh"

  elif [ "${NDTECH_K8S_MODE}" == "destroy-jenkinsx3" ]; then
    echo "destroying jenkins x resources for digital ocean k8s"
    source "${CONTEXT_PATH}/destroy-jenkinsx3.sh"

  else
    echo "invalid NDTECH_K8S_MODE"

  fi
}

process-path
