#!/bin/bash

# clean up
CTNR_NAME='3jmaster'
docker kill ${CTNR_NAME} 2>/dev/null
docker rm ${CTNR_NAME} 2>/dev/null

SERVER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vault-server)

export VAULT_ADDR="http://${SERVER_IP}:8200"

docker run --network=isolated_nw \
  -p 3000:3000 \
  --name ${CTNR_NAME} \
  --env VAULT_ADDR \
  -it 3jmaster/node-web-app \
  /usr/src/start_dev_pipeline.sh
