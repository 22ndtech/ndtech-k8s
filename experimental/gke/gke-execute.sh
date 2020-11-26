#!/bin/bash
echo "starting gke-execute.sh - CONTEXT_PATH = ${CONTEXT_PATH}"

process-path() {

  if [[ "${NDTECH_K8S_MODE}" == "plan" ]]; then
    echo "planning resources at terraform/$1"
    terraform plan

  elif [ "${NDTECH_K8S_MODE}" == "create" ]; then
    echo "creating resources at terraform/$1"
    source "${CONTEXT_PATH}/gcloud-initialize.sh"

    cd "${CONTEXT_PATH}/terraform/$1"
    terraform init
    echo "terraform initialized"

    terraform apply -auto-approve
    # source "${CONTEXT_PATH}/install-kubernetes-metrics.sh"
    # source "${CONTEXT_PATH}/install-kubernetes-dashboard.sh"
    source "${CONTEXT_PATH}/install-istio"
    source "${CONTEXT_PATH}/jenkinsx-install.sh"

  elif [ "${NDTECH_K8S_MODE}" == "destroy" ]; then
    echo "destroying resources at terraform/$1"
    source "${CONTEXT_PATH}/gcloud-initialize.sh"

    cd "${CONTEXT_PATH}/terraform/$1"
    terraform init
    echo "terraform initialized"
    terraform destroy -auto-approve

  elif [ "${NDTECH_K8S_MODE}" == "destroy-istio" ]; then
    source "${CONTEXT_PATH}/destroy-istio.sh"

  elif [ "${NDTECH_K8S_MODE}" == "jenkinsx-install" ]; then
    source "${CONTEXT_PATH}/jenkinsx-install.sh"

  elif [ "${NDTECH_K8S_MODE}" == "jenkinsx-destroy" ]; then
    source "${CONTEXT_PATH}/jenkinsx-destroy.sh"

  elif [ "${NDTECH_K8S_MODE}" == "jenkinsx" ]; then
    source "${CONTEXT_PATH}/jenkinsx.sh"

  else
    echo "invalid NDTECH_K8S_MODE"

  fi
}

process-path "$RELATIVE_PROCESSING_PATH"
