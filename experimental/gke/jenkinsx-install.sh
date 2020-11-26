
#!/bin/bash
#pre-reqs
source "${CONTEXT_PATH}/jenkinsx-setup.sh"

#install
jx upgrade cli
jx boot --batch-mode=true -r ./jx-requirements.yml
