#!/bin/bash

export CTNR_NAME='3jmaster-addo-demo-app'
export IMG_NAME='3jmaster/addo-demo-app'

echo -e ""
echo -e " _|  _   _ |   _  ._   |  o | |   ()    ._ ._ _  "
echo -e "(_| (_) (_ |< (/_ |    |< | | |   (_X   |  | | | "
echo -e ""

# clean up
echo -e "Cleaning up previous containers."

if docker kill ${CTNR_NAME}; then
  echo "docker killed ${CTNR_NAME}"
fi

if docker rm ${CTNR_NAME}; then
  echo "docker removed ${CTNR_NAME}"
fi
