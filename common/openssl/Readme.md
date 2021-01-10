# Create a certification package

## Use the docker-run file to open the openssl container and perform the following
openssl genrsa -out ./jjhegedus.key 4096
- Then create a certificate request file
openssl req -config ./jjhegedus.csr.cnf -new -key ./jjhegedus.key -nodes -out ./jjhegedus.csr

### Now open a new terminal and use the digital ocean tools container to perform the following
### You will need to be sure that the folder mounted on /openssl-certs from the first step is mapped the same for this step
cd /openssl-certs
create the cert using a here doc
## get the certificate to verify it was created
k get csr
k certificate approve jjhegedus-authentication
### Create a copy of the certificate in the mounted /openssl-certs folder
kubectl get csr rob-authentication -o jsonpath='{.status.certificate}' | base64 -d > ./rob.crt
### Create a copy of the kubernetes configuration file (~/.kube/config) and update the username
### Create a roles and bindings file by copying another user's and updating the permissions accordingly
