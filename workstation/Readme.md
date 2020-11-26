# Run VSCode in Docker from Windows
This tutorial - https://www.youtube.com/watch?v=rCdd6u_FXnQ - was followed with minor updates to it to use VSCode as you can see in the dockerfile and the entrypoint.bash file.

The interesting bits wer waiting for VSCode to be closed in the entrypoint.bash file and copying in the vscode.deb file and executing it locally.

The *.ps1 files are convenience files for building, running and debugging the workstation image. The run.ps1 script assumes you are connected on display 0.