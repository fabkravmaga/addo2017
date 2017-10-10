#!/bin/bash

export CTNR_NAME='3jmaster-addo-demo-app'
export IMG_NAME='3jmaster/addo-demo-app'

# clean up
echo -e "Cleaning up previous containers."

if docker kill ${CTNR_NAME}; then
  echo "docker killed ${CTNR_NAME}"
else
  exit 0
fi

if docker rm ${CTNR_NAME}; then
  echo "docker removed ${CTNR_NAME}"
else
  exit 0
fi
