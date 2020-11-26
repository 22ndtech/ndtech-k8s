#!/bin/bash

# Pre-Conditions
# - Connected to a Kubernetes Cluster

echo "PWD = ${PWD} : Source File = mongodb-install.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"

cd ${CONTEXT_PATH}

git clone "https://github.com/ndtech-pipeline/mongodb-kubernetes-operator.git"

cd mongodb-kubernetes-operator

k create -f deploy/crds/mongodb.com_mongodb_crd.yaml

k create -f deploy/ -n ndtech

k apply -f deploy/crds/mongodb.com_v1_mongodb_cr.yaml -n ndtech

