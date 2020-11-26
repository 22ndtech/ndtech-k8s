$Env:NDTECH_K8S_HOME="C:/Projects/Git/22ndtech/ndtech/ndtech-k8s"

$Env:JX_VALUE_ADMINUSER_PASSWORD= Get-Content -path "D:\OneDrive\22ndTech\azure\jx-value-adminuser-password.txt"
$Env:JX_VALUE_PIPELINEUSER_USERNAME="ndtech-pipeline"
$Env:JX_VALUE_PIPELINEUSER_EMAIL="ndtech-pipeline@22ndtech.com"
$Env:JX_VALUE_PIPELINEUSER_TOKEN = Get-Content -path "D:\OneDrive\22ndTech\GitHub\ndtech-pipeline-token.txt"
$Env:DIGITAL_OCEAN_INITIAL_TOKEN = Get-Content -path "D:\OneDrive\22ndTech\DigitalOcean\digital-ocean-initial-token.txt"
$Env:JENKINS_X_BUCKETREPO_USERNAME = "ndtech-pipeline"
$Env:JENKINS_X_BUCKETREPO_PASSWORD = Get-Content -path "D:\OneDrive\22ndTech\azure\jx-value-adminuser-password.txt"

$Env:AZURE_NDTECH_K8S_SUBSCRIPTION_ID = Get-Content -path "D:\OneDrive\22ndtech\Azure\ndtech-k8s-subscription-id.txt"
$Env:AZURE_NDTECH_K8S_TENANT_ID = Get-Content -path "D:\OneDrive\22ndtech\Azure\ndtech-k8s-tenant-id.txt"
$Env:AZURE_NDTECH_K8S_SP_ID = Get-Content -path "D:\OneDrive\22ndtech\Azure\ndtech-k8s-sp-id.txt"
$Env:AZURE_NDTECH_K8S_SP_PASSWORD = Get-Content -path "D:\OneDrive\22ndtech\Azure\ndtech-k8s-sp-password.txt"
$Env:AZURE_NDTECH_K8S_RESOURCE_GROUP_NAME = Get-Content -path "D:\OneDrive\22ndtech\Azure\ndtech-k8s-resource-group-name.txt"
$Env:AZURE_NDTECH_TERRAFORM_STORAGE_ACCOUNT_KEY = Get-Content -path "D:\OneDrive\22ndtech\Azure\ndtech-terraform-storage-account-key.txt"
$Env:AZURE_NDTECH_TERRAFORM_STORAGE_ACCOUNT_NAME = Get-Content -path "D:\OneDrive\22ndtech\Azure\ndtech-terraform-storage-account-name.txt"
$Env:AZURE_NDTECH_TERRAFORM_STORAGE_CONTAINER_NAME = Get-Content -path "D:\OneDrive\22ndtech\Azure\ndtech-terraform-storage-container-name.txt"

