#!/bin/bash

# clean up so that it can run again
CTNR_NAME='3jmaster-addo-demo-app'
NETWORK='isolated_nw'
SERVER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vault-server)
VAULT_ADDR="http://${SERVER_IP}:8200"

docker kill ${CTNR_NAME} 2>/dev/null
docker rm ${CTNR_NAME} 2>/dev/null

docker run -d \
  --network=${NETWORK} \
  --restart unless-stopped \
  -p 3000:3000 \
  --name ${CTNR_NAME} \
  -e VAULT_ADDR \
  -e VAULT_
  3jmaster/addo-demo-app
