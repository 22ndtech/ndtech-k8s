docker run --rm -it `
  -v c:\data:\data `
  -e DISPLAY=172.27.16.1:0 `
  --entrypoint /bin/bash 22ndtech/vscode