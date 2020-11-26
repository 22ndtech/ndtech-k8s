#!/bin/bash
echo "starting gke-execute.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"

process-path() {

  if [[ "${NDTECH_K8S_MODE}" == "plan" ]]; then
    echo "planning resources at terraform/$1"
    terraform plan

  elif [ "${NDTECH_K8S_MODE}" == "jenkinsx-create" ]; then
    echo "creating resources at terraform/$1"
    source "${CONTEXT_PATH}/gcloud-initialize.sh"

    cd "${CONTEXT_PATH}/terraform/$1"
    terraform init
    echo "terraform initialized"

    echo "GOOGLE_APPLICATION_CREDENTIALS = ${GOOGLE_APPLICATION_CREDENTIALS}"
    terraform apply -auto-approve
    mkdir "${CONTEXT_PATH}/jenkinsx-prod"
    terraform output jx_requirements > "${CONTEXT_PATH}/jenkinsx-prod/jx-requirements.yml"
    cd "${CONTEXT_PATH}/jenkinsx-prod"
    jx boot --requirements jx-requirements.yml

  elif [ "${NDTECH_K8S_MODE}" == "jenkinsx-destroy" ]; then
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
