./initialize-environment-variables.ps1
docker run --rm `
  -v ${PWD}:/usr/src `
  -v $Env:NDTECH_K8S_HOME/common:/usr/src/common `
  -v c:\data\openssl-certs:/openssl-certs `
  -v C:\Projects\Git\22ndtech\ndtech\ndtech-k8s\common:/usr/common `
  -v D:\OneDrive\22ndTech\DigitalOcean\mongodb-user-name.txt:/mongodb-user-name.txt `
  -v D:\OneDrive\22ndTech\DigitalOcean\mongodb-user-password.txt:/mongodb-user-password.txt `
  -e NDTECH_K8S_MODE="debug" `
  -e AWS_ACCESS_KEY_ID="$($aws_access_key_id."Access key ID")" `
  -e AWS_SECRET_ACCESS_KEY="$($aws_secret_access_key."Secret access key")" `
  -e AWS_DEFAULT_REGION="us-west-2" `
  -e CONTEXT_PATH=/root `
  -e JX_NO_DELETE_TMP_DIR=true `
  -e JX_VALUE_PIPELINEUSER_USERNAME=$ENV:JX_VALUE_PIPELINEUSER_USERNAME `
  -e JX_VALUE_PIPELINEUSER_TOKEN=$ENV:JX_VALUE_PIPELINEUSER_TOKEN `
  -e DIGITAL_OCEAN_INITIAL_TOKEN="$Env:DIGITAL_OCEAN_INITIAL_TOKEN" `
  -it --entrypoint /bin/bash ndtech-k8s-digital-ocean-tools:latest