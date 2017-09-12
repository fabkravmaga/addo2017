#!/bin/bash

SERVER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vault-server)
VAULT_ADDR="http://${SERVER_IP}:8200"
VAULT_AUTH_DEFAULT='USERNAMEPASSWORD' # or LDAP or TOKEN or GITHUB
NODE_TLS_REJECT_UNAUTHORIZED=1 # Set to 0 to disable TLS (ex. vault deployed with self-signed certificate)
NAME='vault-ui'
NETWORK='isolated_nw'
PORT=80

docker run -d \
--network=${NETWORK} \
-p $PORT:8000 \
-e VAULT_URL_DEFAULT=$VAULT_ADDR \
-e VAULT_AUTH_DEFAULT=$VAULT_AUTH_DEFAULT \
-e NODE_TLS_REJECT_UNAUTHORIZED=$NODE_TLS_REJECT_UNAUTHORIZED \
--restart unless-stopped \
--name $NAME \
djenriquez/vault-ui

sleep 3
open http://127.0.0.1:80
