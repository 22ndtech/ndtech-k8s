#!/bin/bash
echo "starting /digital/create-cluster.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"

cp -r /usr/src/.config /root

doctl kubernetes cluster create ndtech \
  --version 1.20.2-do.0 \
  --count 2 \
  --size s-4vcpu-8gb \
  --region sfo2

echo "after cluster created"