  #!/bin/bash
  export PATH="${CONTEXT_PATH}/gcp-cli/google-cloud-sdk/bin:$PATH"
  echo "authenticating service account"
  gcloud auth activate-service-account --key-file "/ndtech-k8s-admin-key.json"
  echo "service account authenticated!!!"      
  gcloud config set account ndtech-k8s-admin@jjh1-289322.iam.gserviceaccount.com
  echo "account set to ndtech-k8s...!!!" 
  gcloud config set project "jjh1-289322"