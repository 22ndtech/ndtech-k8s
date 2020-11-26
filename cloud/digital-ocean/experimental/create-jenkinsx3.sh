#!/bin/bash
echo "starting /digital/create-jenkinsx3.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"


cp -r /usr/src/.kube /root/
cp -r /usr/src/.config /root
cp -r /usr/src/.jx3 /root

mkdir /root/jenkinsx3
cd /root/jenkinsx3

curl -L https://github.com/jenkins-x/jx-cli/releases/download/v3.0.550/jx-cli-linux-amd64.tar.gz | tar xzv 
mv jx /usr/local/bin

jx upgrade plugins

git clone https://github.com/ndtech-pipeline/jx3-kubernetes.git jx3-kubernetes
cd jx3-kubernetes
jx admin operator --username $JX_VALUE_PIPELINEUSER_USERNAME --token $JX_VALUE_PIPELINEUSER_TOKEN

cp -r /root/.jk3 /usr/src