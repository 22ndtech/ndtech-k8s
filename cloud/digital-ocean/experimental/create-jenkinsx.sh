#!/bin/bash
echo "starting /digital/create-jenkinsx.sh : CONTEXT_PATH = ${CONTEXT_PATH} : NDTECH_K8S_MODE = ${NDTECH_K8S_MODE}"

cp -r /usr/src/.kube /root/
cp -r /usr/src/.config /root

mkdir /root/jenkinsx
cd /root/jenkinsx
jx upgrade cli
cp "${CONTEXT_PATH}/${RELATIVE_PROCESSING_PATH}/jx-requirements.yml" ./

jx boot --batch-mode=true -r ./jx-requirements.yml
echo "jx boot sometimes fails the first time through so let's try it again"
jx boot --batch-mode=true -r ./jx-requirements.yml

echo "after jx boot"
cp -r /root/.jx /usr/src
echo "after copying jenkinsx configuration"
cp -r /root/jenkinsx /usr/src
echo "after copying /root/jenkinsx"
cp -r /tmp /usr/src
echo "after copying /tmp"