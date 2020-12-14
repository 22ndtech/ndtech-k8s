docker run --rm `
  -v ${PWD}:/usr/src `
  -v D:\OneDrive\22ndTech\crets\22ndtech-admin\openssl-certs:/openssl-certs `
  -e NDTECH_K8S_MODE="debug" `
  -it --entrypoint /bin/sh ndtech-openssl:latest