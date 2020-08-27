#!/bin/bash
echo 'starting execute.sh'
cd /root/terraform
terraform init
terraform apply -auto-approve