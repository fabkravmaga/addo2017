#!/bin/bash

export GIT_ROOT=$(git rev-parse --show-toplevel)
export CTNR_NAME='3jmaster-addo-demo-app'
export IMG_NAME='3jmaster/addo-demo-app'

# clean up
echo -e "Cleaning up previous containers."
docker kill ${CTNR_NAME} 2>/dev/null
docker rm ${CTNR_NAME} 2>/dev/null
