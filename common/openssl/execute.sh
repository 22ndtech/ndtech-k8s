#!/bin/bash
echo "starting execute.sh - CONTEXT_PATH = ${CONTEXT_PATH}"
openssl req -nodes -x509 k-newkey rsa:4096 -keyout /openssl-certs/key.pem -out /openssl-certs/cert.pem -days 365 -subj "/C=US/ST=Colorado/L=Centennial/O=ndtech/OU=IT Department/CN=jaackdreality.com"