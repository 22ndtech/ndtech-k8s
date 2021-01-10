# one argument... the username
docker run --rm `
  -v ${PWD}:/usr/src `
  -v D:\OneDrive\22ndTech\crets\$args\openssl-certs:/openssl-certs `
  -e NDTECH_K8S_MODE="debug" `
  -it --entrypoint /bin/sh ndtech-openssl:latest