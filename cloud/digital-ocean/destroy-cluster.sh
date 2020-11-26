#!/bin/bash
echo "starting /digital/delete-cluster.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"

ndtech_k8s_cluster_id=$(doctl kubernetes cluster list | sed -n '/.*ndtech-k8s-cluster/p' | cut -c1-36)

doctl kubernetes cluster delete -f "$ndtech_k8s_cluster_id"