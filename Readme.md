# Introduction 
ndtech-k8s is a hodgepodge of information about the development of the ndtech kubernetes assets

# Contribute
Hmmm

# Setting up a windows dev environment
## Install Docker for Windows
## Install Visual Studio Code
## Install kubectl
https://kubernetes.io/docs/tasks/tools/install-kubectl/
## Install Google Cloud SDK
https://cloud.google.com/sdk/docs/install
## Install Octant
https://github.com/vmware-tanzu/octant/releases
## Install the Jenkins X Plugin for Octant
https://github.com/jenkins-x/octant-jx
Need to copy the octant-jx.exe and otant-jxo.exe to C:\Users\jeff\AppData\Local\octant\plugins before starting octant for the plugins to register. Very good directions except the path which was displayed in the command line when launching octant.
## Install Visual Studio Community 2017
Required for HoloLens and MagicLeap development


# Digital Ocean
## Connecting to the cluster
doctl auth init -t $DIGITAL_OCEAN_INITIAL_TOKEN
doctl kubernetes cluster kubeconfig save ndtech-k8s-cluster

## build container
docker build --force-rm -f "digital-ocean/dockerfile" -t ndtech-k8s-digital-ocean:latest --build-arg CONTEXT_PATH=/root .

## build tools container
docker build --force-rm -f "digital-ocean/dockerfile" -t ndtech-k8s-digital-ocean-tools:latest --build-arg CONTEXT_PATH=/root .

## launch container for debug
docker run --rm -v ${PWD}:/usr/src -v C:\Projects\Git\22ndtech\orchestration\ndtech-k8s\common:/usr/common -v C:\Projects\Git\22ndtech\orchestration\ndtech-k8s\cloud\digital-ocean:/usr/digital-ocean -e NDTECH_K8S_MODE="debug" -e AWS_ACCESS_KEY_ID="$($aws_access_key_id."Access key ID")" -e AWS_SECRET_ACCESS_KEY="$($aws_secret_access_key."Secret access key")" -e AWS_DEFAULT_REGION="us-west-2" -e CONTEXT_PATH=/root -e JX_NO_DELETE_TMP_DIR=true -e JX_VALUE_PIPELINEUSER_USERNAME=$ENV:JX_VALUE_PIPELINEUSER_USERNAME -e JX_VALUE_PIPELINEUSER_TOKEN=$ENV:JX_VALUE_PIPELINEUSER_TOKEN -e DIGITAL_OCEAN_INITIAL_TOKEN="$Env:DIGITAL_OCEAN_INITIAL_TOKEN" -it --entrypoint /bin/bash ndtech-k8s-digital-ocean-tools:latest

## launch container to create cluster
docker run --rm -v ${PWD}:/usr/src -e NDTECH_K8S_MODE="create-cluster" -e RELATIVE_PROCESSING_PATH="digital-ocean/" -e 
AWS_ACCESS_KEY_ID="$($aws_access_key_id."Access key ID")" -e AWS_SECRET_ACCESS_KEY="$($aws_secret_access_key."Secret access key")" -e AWS_DEFAULT_REGION="us-west-2" -e CONTEXT_PATH=/root -e DIGITAL_OCEAN_INITIAL_TOKEN="$Env:DIGITAL_OCEAN_INITIAL_TOKEN" -e JX_VALUE_ADMINUSER_PASSWORD=$ENV:JX_VALUE_ADMINUSER_PASSWORD -e JX_VALUE_PIPELINEUSER_USERNAME=$ENV:JX_VALUE_PIPELINEUSER_USERNAME -e JX_NO_DELETE_TMP_DIR=true -e JX_VALUE_PIPELINEUSER_EMAIL=$ENV:JX_VALUE_PIPELINEUSER_EMAIL -e JX_VALUE_PIPELINEUSER_TOKEN=$ENV:JX_VALUE_PIPELINEUSER_TOKEN prod-do-ndtech-k8s-cluster:latest

## launch container to destroy cluster
docker run --rm -v ${PWD}:/usr/src -e NDTECH_K8S_MODE="destroy-cluster" -e RELATIVE_PROCESSING_PATH="digital-ocean/" -e 
AWS_ACCESS_KEY_ID="$($aws_access_key_id."Access key ID")" -e AWS_SECRET_ACCESS_KEY="$($aws_secret_access_key."Secret access key")" -e AWS_DEFAULT_REGION="us-west-2" -e CONTEXT_PATH=/root -e DIGITAL_OCEAN_INITIAL_TOKEN="$Env:DIGITAL_OCEAN_INITIAL_TOKEN" -e JX_VALUE_ADMINUSER_PASSWORD=$ENV:JX_VALUE_ADMINUSER_PASSWORD -e JX_VALUE_PIPELINEUSER_USERNAME=$ENV:JX_VALUE_PIPELINEUSER_USERNAME -e JX_NO_DELETE_TMP_DIR=true -e JX_VALUE_PIPELINEUSER_EMAIL=$ENV:JX_VALUE_PIPELINEUSER_EMAIL -e JX_VALUE_PIPELINEUSER_TOKEN=$ENV:JX_VALUE_PIPELINEUSER_TOKEN prod-do-ndtech-k8s-cluster:latest

## Command Line Utility
https://github.com/digitalocean/doctl

## Configure the secrets using a template in the chart at ./digital-ocean/bucketrepo-auth-secrets - JENKINS_X_BUCKET_REPO_USERNAME and JENKINS_X_BUCKET_REPO_PASSWORD environment variables must be set first
### This wasn't working for some reason but I'm not heading down the Jenkins x path at the moment though I might come back to it later
helm template . --set JENKINS_X_BUCKET_REPO_USERNAME="$Env:JENKINS_X_BUCKETREPO_USERNAME",JENKINS_X_BUCKET_REPO_PASSWORD="$Env:JENKINS_X_BUCKETREPO_PASSWORD"

## Debugging
### Slack conversation on digital ocean ingress issues
https://app.slack.com/client/T09NY5SBT/C9MBGQJRH/thread/C9MBGQJRH-1540820049.070300

## Configure External DNS
### Created the service account, cluster role, cluster role binding and deployment yaml files
### Also created an API token with permissions according to this blog - https://platform9.com/blog/integrating-external-dns-with-kubernetes/
external-dns-token: zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

### Create Secret - I'll load the secret into kubernetes from an environment variable to avoid storing it in the repo
kubectl create secret generic -n ndtech external-dns-token --from-literal=token=$ENV:DO_EXTERNAL_DNS_TOKEN



# Google Kubernetes Engine
## Running with Jenkins X 3
### Launch container for debug
docker run --rm -v ${PWD}:/usr/src -e NDTECH_K8S_MODE="debug" -e AWS_ACCESS_KEY_ID="$($aws_access_key_id."Access key ID")" -e AWS_SECRET_ACCESS_KEY="$($aws_secret_access_key."Secret access key")" -e AWS_DEFAULT_REGION="us-west-2" -e CONTEXT_PATH=/root -e JX_NO_DELETE_TMP_DIR=true -e JX_VALUE_PIPELINEUSER_USERNAME=$ENV:JX_VALUE_PIPELINEUSER_USERNAME -e JX_VALUE_PIPELINEUSER_TOKEN=$ENV:JX_VALUE_PIPELINEUSER_TOKEN -it --entrypoint /bin/bash ndtech-k8s-gke-jx3:latest

# Bash Scripting
## Append data to a text file by typing the text
cat >>test.txt

## Append data to a text file using a here document
cat > ./test.txt << EOF; $(echo)
http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main
http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community
http://dl-cdn.alpinelinux.org/alpine/edge/community
EOF

# Alpine
## Alpine edge community repo
http://dl-cdn.alpinelinux.org/alpine/edge/community

## Install Debian Packages on Alpine
apline now has dpkg inside its repository and you can install it by apk add dpkg and you can use dpkg -i *.deb to install the deb you want

# Powershell
## Tee-Object - https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/tee-object?view=powershell-7
### Output processes to a file and to the console
Get-Process | Tee-Object -FilePath "C:\Test1\testfile2.txt"
### Upgrade Powershell
iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
### Update PowerShell Profile
C:\Users\jeff\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 for VS Code
or
C:\Users\jeff\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
for powershell 7.1.0 shell
the value for $profile is different between them. not sure why

### Install environment variables
D:\OneDrive\22ndTech\crets\ndtech-environment-setup.ps1
### Tee in Powershell
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/tee-object?view=powershell-7.1
Get-ChildItem -Path D: -File -System -Recurse |
  Tee-Object -FilePath "c:\test\AllSystemFiles.txt" -Append |
    Out-File c:\test\NewSystemFiles.txt

# Kubernetes
## Secrets
### Create Generic Secret
kubectl create secret generic -n jx lighthouse-hmac-token --from-literal=hmac=zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

### Create Opaque Secret
k create secret opaque -n ndtech 

### Installing the dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.4/aio/deploy/recommended.yaml

### Access a shell in a running pod - https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/
kubectl exec --stdin --tty <pod-name> -- /bin/bash

### Digital Ocean - Kubernetes Networking
https://www.digitalocean.com/community/tutorials/how-to-inspect-kubernetes-networking#finding-and-entering-pod-network-namespaces

### Kubernetes Cheat Sheet
https://kubernetes.io/docs/reference/kubectl/cheatsheet/

## Tools
### kubetail.sh
#### To tail all logs in the current namespace (works with kube ens)
kubetail ".*" --regex
#### Had to update the kubetail.sh file by removing the --color=never from the grep command on line 

# Jenkins X
## Jenkins X 3
### Hacking on Jenkins X
https://jenkins-x.io/community/code/
Go 1.13.8 Windows Installer - https://golang.org/dl/go1.13.8.windows-amd64.msi
Go 1.13.8 Linux Installer - https://golang.org/dl/go1.13.8.linux-amd64.tar.gz

# Linux Command Linx
## Print in color on linux command line
printf '\x1b\x5b1;31;40m\tMerry Christmas\n\x1b\x5b0;37;40m'

## Install ps on debian
apt-get update && apt-get install -y procps


k logs kube-proxy-4r4cf -f=true

# MongoDB on Kubernetes
k create -f deploy/ -n ndtech

## Deploy a 3 node mogodb replica set
k apply -f deploy/crds/mongodb.com_v1_mongodb_cr.yaml -n ndtech
### Failed because I didn't have SCRAM credentials set up - to set them up
k create secret generic mongo-db-user-secret --from-file=password=/mongodb-user-password.txt

## Delete the mongodb deployment
k delete -f deploy/crds/mongodb.com_v1_mongodb_cr.yaml -n ndtech

# Azure
## Setup

### Login to Azure
Connect-AzAccount

### Create a self signed certificate
$cert = New-SelfSignedCertificate -CertStoreLocation "cert:\LocalMachine\My" -Subject "CN=ndtech-k8s-admin-cert" -KeySpec KeyExchange

### base64 encode the cert
$keyValue = [System.Convert]::ToBase64String($cert.GetRawCertData())

### Create a Service Principal using the certificate
$sp = New-AzADServicePrincipal -DisplayName "ndtech-k8s-admin" -CertValue $keyValue -EndDate $cert.NotAfter -StartDate $cert.NotBefore

### Example
PS C:\Windows\System32> $cert = New-SelfSignedCertificate -CertStoreLocation "cert:\LocalMachine\My" -Subject "CN=ndtech-k8s-admin-cert" -KeySpec KeyExchange
PS C:\Windows\System32> $keyValue = [System.Convert]::ToBase64String($cert.GetRawCertData())
PS C:\Windows\System32> $sp = New-AzADServicePrincipal -DisplayName "ndtech-k8s-admin" -CertValue $keyValue -EndDate $cert.NotAfter -StartDate $cert.NotBefore
PS C:\Windows\System32> $sp

ServicePrincipalNames : {7e0816c3-dce1-4d94-86fc-e8bb331e75e2, http://ndtech-k8s-admin}
ApplicationId         : 7e0816c3-dce1-4d94-86fc-e8bb331e75e2
ObjectType            : ServicePrincipal
DisplayName           : ndtech-k8s-admin
Id                    : e5ba153d-a675-4dbb-a104-4ee355af1f16


### Create a service principal for logging in with a password
az ad sp create-for-rbac --skip-assignment --name aks-getting-started-sp -o json
{ "appId": "$ENV:APP_ID", "displayName": "ndtech-k8s-sp", "name": "http://ndtech-k8s-sp", "password": "$ENV:AZURE_PASSWORD", "tenant": "$ENV:TENNANT_ID" }



### Create Role Assignment with Powershell
New-AzRoleAssignment -RoleDefinitionName "Owner" -ServicePrincipalName "$ENV:SERVICE_PRINCIPAL_NAME"


### Create a Role Assignement with the az cli
az role assignment create --assignee $AZURE_NDTECH_K8S_SP_ID \
--scope "/subscriptions/$AZURE_NDTECH_K8S_SUBSCRIPTION_ID" \
--role Contributor

{
  "canDelegate": null,
  "condition": null,
  "conditionVersion": null,
  "description": null,
  "id": "/subscriptions/e595e532-bfff-4efb-a484-78cb19294ced/providers/Microsoft.Authorization/roleAssignments/5c1ae048-c9c9-4695-a696-7aec1a533457",
  "name": "5c1ae048-c9c9-4695-a696-7aec1a533457",
  "principalId": "1b318706-91f2-4193-931e-837043f1c864",
  "principalType": "ServicePrincipal",
  "roleDefinitionId": "/subscriptions/e595e532-bfff-4efb-a484-78cb19294ced/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c",
  "scope": "/subscriptions/e595e532-bfff-4efb-a484-78cb19294ced",
  "type": "Microsoft.Authorization/roleAssignments"
}

### Exporting Certificates
Use certmgr.msc

### Create a Resource Group for the cluster
az group create -n "ndtech-k8s-cluster-node-resource-group" -l "westcentralus"

{
  "id": "/subscriptions/e595e532-bfff-4efb-a484-78cb19294ced/resourceGroups/ndtech-k8s-resource-group",
  "location": "westcentralus",
  "managedBy": null,
  "name": "ndtech-k8s-resource-group",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}

### Azure VM Pricing
https://azure.microsoft.com/en-us/pricing/details/virtual-machines/ubuntu-advantage-standard/

### Create the cluster
az aks create -n ndtech-k8s-cluster \
--resource-group $RESOURCEGROUP \
--location westcentralus \
--kubernetes-version 1.19.3 \
--load-balancer-sku standard \
--nodepool-name default \
--node-count 2 \
--node-vm-size Standard_B2s  \
--node-osdisk-size 250 \
--generate-ssh-keys \
--network-plugin kubenet \
--service-principal $SERVICE_PRINCIPAL \
--client-secret $SERVICE_PRINCIPAL_SECRET \
--output none

### List Clusters
az aks list -o table
Name                Location       ResourceGroup              KubernetesVersion    ProvisioningState    Fqdn
------------------  -------------  -------------------------  -------------------  -------------------  -----------------------------------------------------------------------
ndtech-k8s-cluster  westcentralus  ndtech-k8s-resource-group  1.19.3               Succeeded            ndtech-k8s-ndtech-k8s-resou-e595e5-e9dd0e0b.hcp.westcentralus.azmk8s.io

#### if your SP key is invalid, generate a new one:
SERVICE_PRINCIPAL_SECRET=(az ad sp credential reset --name $SERVICE_PRINCIPAL | jq -r '.password')


## build container - first you have to cd to the azure folder
docker build --force-rm -f "dockerfile" -t ndtech-k8s-azure-jx3:latest --build-arg CONTEXT_PATH=/root .


## Terraform Storage
### Create a Resource Group to store the terraform state so it isn't deleted when the ndtech-k8s-resource-group is deleted
az group create -n "ndtech-terraform-resource-group" -l "westcentralus"
{
  "id": "/subscriptions/e595e532-bfff-4efb-a484-78cb19294ced/resourceGroups/ndtech-terraform-resource-group",
  "location": "westcentralus",
  "managedBy": null,
  "name": "ndtech-terraform-resource-group",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}

### Create Storage Account
az storage account create --resource-group "ndtech-terraform-resource-group" --name "ndtechtfstorageact" --sku Standard_LRS --encryption-services blob

### Get the Storage Account Key
ACCOUNT_KEY=$(az storage account keys list --resource-group "ndtech-terraform-resource-group" --account-name "ndtechtfstorageact" --query [0].value -o tsv)

### Create a storage container
az storage container create --name $AZURE_NDTECH_TERRAFORM_STORAGE_CONTAINER_NAME --account-name $AZURE_NDTECH_TERRAFORM_STORAGE_ACCOUNT_NAME --account-key $AZURE_NDTECH_TERRAFORM_STORAGE_ACCOUNT_KEY


# FluxCD
## Instal v2
curl -s https://toolkit.fluxcd.io/install.sh | sh
## Bootstrap ndtech-staging repo
flux bootstrap github --owner="22ndtech" --repository="ndtech-flux-fleet" --branch="main" --path="ndtech-staging" --private=false team="ndtech-k8s-admin" --verbose --log-level="debug"


# Docker
## Remove all containers in powershell
docker rm $(docker ps -a -q)

# Github
D:\OneDrive\22ndTech\crets\ndtech-environment-setup.ps1

# Get linux distro
cat /proc/version

# To delete a namespace stuck in the terminating state
## k get ns flux-system -o json > /usr/src/flux-system.json
## Remove kubernetes from the list of finalizers in the spec section
### k replace --raw "/api/v1/namespaces/flux-system/finalize" -f /usr/src/flux-system.json