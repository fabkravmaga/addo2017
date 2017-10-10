#!/bin/bash

CTNR_NAME='3jmaster-addo-demo-app'
IMG_NAME='3jmaster/addo-demo-app'
SERVER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vault-server)
VAULT_ADDR="http://${SERVER_IP}:8200"

echo "PROJECT DIR: $CI_PROJECT_DIR"
echo "JOB ID: $CI_JOB_ID"
echo "VAULT_USERNAME: $VAULT_USERNAME"
echo "VAULT_ADDR $VAULT_ADDR"

# clean up
echo -e "Cleaning up previous containers."
docker kill ${CTNR_NAME} 2>/dev/null
docker rm ${CTNR_NAME} 2>/dev/null

# run
docker run --network=isolated_nw \
  -d  \
  -p 3000:3000 \
  --name ${CTNR_NAME} \
  --env VAULT_ADDR \
  --env VAULT_USERNAME \
  --env VAULT_PASSWORD \
  ${IMG_NAME}

# tail docker logs
docker logs -f ${CTNR_NAME}
