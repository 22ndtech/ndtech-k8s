#!/bin/bash
echo "starting execute.sh - CONTEXT_PATH = ${CONTEXT_PATH}"

if [[ "${NDTECH_K8S_MODE}" == "plan" ]]; then
  echo "planning resources at $PWD - NO-OP"

elif [ "${NDTECH_K8S_MODE}" == "create" ]; then
  echo "creating resources at $PWD"
  source /usr/gke/gcloud-initialize.sh
  cd /root
  mkdir exec
  cd exec
  git clone https://github.com/ndtech-pipeline/ndtech-jx3-terraform-gke.git
  cd ndtech-jx3-terraform-gke
  git config --global user.email "ndtech-pipeline@22ndtech.com"
  git config --global user.name "ndtdech-pipeline@22ndtech.com"
  export TF_VAR_jx_bot_token=$JX_VALUE_PIPELINEUSER_TOKEN
  terraform init
  terraform apply -auto-approve

elif [ "${NDTECH_K8S_MODE}" == "destroy" ]; then
  echo "destroying resources at $PWD"
  source /usr/gke/gcloud-initialize.sh
  cd /root
  mkdir exec
  cd exec
  git clone https://github.com/ndtech-pipeline/ndtech-jx3-terraform-gke.git
  cd ndtech-jx3-terraform-gke
  git config --global user.email "ndtech-pipeline@22ndtech.com"
  git config --global user.name "ndtdech-pipeline@22ndtech.com"
  export TF_VAR_jx_bot_token=$JX_VALUE_PIPELINEUSER_TOKEN
  terraform init
  terraform destroy -auto-approve

fi
