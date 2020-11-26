#!/bin/bash
echo "starting execute.sh - CONTEXT_PATH = ${CONTEXT_PATH}"

if [[ "${NDTECH_K8S_MODE}" == "plan" ]]; then
  echo "planning resources at $PWD"
  source plan.sh

elif [ "${NDTECH_K8S_MODE}" == "apply" ]; then
  echo "creating resources at $PWD"
  source apply.sh

elif [ "${NDTECH_K8S_MODE}" == "destroy" ]; then
  source destroy.sh

elif [ "${NDTECH_K8S_MODE}" == "debug" ]; then
  source debug.sh

fi
