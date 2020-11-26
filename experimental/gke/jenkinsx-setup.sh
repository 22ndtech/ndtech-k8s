#!/bin/bash'

echo "starting jenkinsx-setup.sh"

# pre-reqs
source "/root/gcloud-initialize.sh"

# create gke cluster
cd /root
mkdir jenkinsx
terraform init
echo "after terraform init"

# install jenkins x
cd jenkinsx
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-linux-amd64.tar.gz" | tar xzv "jx"
mv jx /usr/local/bin
cp /root/jx-requirements.yml ./