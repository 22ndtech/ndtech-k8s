#!/bin/bash
echo 'starting gke-execute.sh'

process-path () {
  cd "/root/terraform/$1"
  echo "processing path"
  pwd
  terraform init

  if [[ "${NDTECH_K8S_MODE}" == "plan" ]]
  then
      echo "planning resources at terraform/$1"
      terraform plan

  elif [ "${NDTECH_K8S_MODE}" == "create" ]
  then
      echo "creating resources at terraform/$1"
      terraform apply -auto-approve
    
      cd /root/k8s-metrics
      aws eks --region us-west-2 update-kubeconfig --name prod-ndtech-k8s-cluster
      kubectl apply -f metrics-server-0.3.6/deploy/1.8+/
      # install the kubernetes dashboard
      kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

  elif [ "${NDTECH_K8S_MODE}" == "destroy" ]
  then
    echo "destroying resources at terraform/$1"
    terraform destroy -auto-approve
  fi
}

if [ "${NDTECH_K8S_MODE}" == "debug" ]
then
  cd "/root/terraform/${RELATIVE_PROCESSING_PATH}"
  pwd
  echo "launching container for debug"
else
  process-path "$RELATIVE_PROCESSING_PATH"
fi