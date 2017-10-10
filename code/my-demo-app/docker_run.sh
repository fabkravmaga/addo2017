#!/bin/bash

export CTNR_NAME='3jmaster-addo-demo-app'
export IMG_NAME='3jmaster/addo-demo-app'
export SERVER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vault-server)
export VAULT_ADDR="http://${SERVER_IP}:8200"
export CI_COMMIT_SHA=${CI_COMMIT_SHA}

echo "CI_JOB_ID: $CI_JOB_ID"
echo "CI_COMMIT_SHA: $CI_COMMIT_SHA"
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

# tail docker logs
#docker logs -f ${CTNR_NAME}
