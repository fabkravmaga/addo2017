#!/bin/bash

export CTNR_NAME='3jmaster-addo-demo-app'
export IMG_NAME='3jmaster/addo-demo-app'
export SERVER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vault-server)
export VAULT_ADDR="http://${SERVER_IP}:8200"
export CI_COMMIT_SHA=${CI_COMMIT_SHA}

echo -e ""
echo -e " _|  _   _ |   _  ._   ._     ._ "
echo -e "(_| (_) (_ |< (/_ |    |  |_| | |"
echo -e ""

: "${VAULT_USERNAME?Need to set your VAULT_USERNAME}"
: "${VAULT_PASSWORD?Need to set your VAULT_PASSWORD}"
: "${VAULT_ADDR?Need to set your VAULT_ADDR}"

echo "VAULT_USERNAME: $VAULT_USERNAME"
echo "VAULT_ADDR: $VAULT_ADDR"

# run
docker run --network=isolated_nw \
  -d  \
  -p 3000:3000 \
  --name ${CTNR_NAME} \
  --env VAULT_ADDR \
  --env VAULT_USERNAME \
  --env VAULT_PASSWORD \
  --env CI_COMMIT_SHA \
  ${IMG_NAME}

if [ -n "$CI_JOB_ID" ]; then
  echo "CI_JOB_ID: $CI_JOB_ID"
  echo "CI_COMMIT_SHA: $CI_COMMIT_SHA"
  echo "Job: Run Done"
  exit 0
else
  echo "Local: Run Done"
  docker logs -f ${CTNR_NAME}
fi
