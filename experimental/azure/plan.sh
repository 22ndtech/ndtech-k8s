#!/bin/bash

echo "planning resources at $PWD"

cd /root
source login.sh
mkdir exec
cd exec
git clone https://github.com/22ndtech-admin/jx3-azure-terraform.git
cd jx3-azure-terraform

git config --global user.email "ndtech-pipeline@22ndtech.com"
git config --global user.name "ndtdech-pipeline@22ndtech.com"
export TF_VAR_JX_BOT_TOKEN=$JX_VALUE_PIPELINEUSER_TOKEN
export ARM_CLIENT_ID=$AZURE_NDTECH_K8S_SP_ID
export ARM_CLIENT_SECRET=$AZURE_NDTECH_K8S_SP_PASSWORD
export ARM_SUBSCRIPTION_ID=$AZURE_NDTECH_K8S_SUBSCRIPTION_ID
export ARM_TENANT_ID=$AZURE_NDTECH_K8S_TENANT_ID

az configure --defaults location=westcentralus group=$AZURE_NDTECH_K8S_RESOURCE_GROUP_NAME
terraform init
terraform plan \
    -var jx_bot_token="$JX_VALUE_PIPELINEUSER_TOKEN"