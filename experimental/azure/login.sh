#!/bin/bash
echo "starting login.sh - CONTEXT_PATH = ${CONTEXT_PATH}"

az login --service-principal -u $AZURE_NDTECH_K8S_SP_ID -p $AZURE_NDTECH_K8S_SP_PASSWORD --tenant $AZURE_NDTECH_K8S_TENANT_ID