#!/bin/bash

NODE_TLS_REJECT_UNAUTHORIZED=1 # Set to 0 to disable TLS (ex. vault deployed with self-signed certificate)
NAME='vault-server'
NETWORK='isolated_nw'
VAULT_DEV_ROOT_TOKEN_ID='addo2017rocksmysocks'

echo -e "- THIS RUNS IN DETACHED MODE SO KEEP THIS SHELL RUNNING IN THE BACKGROUND -"
echo -e "- OPEN A NEW SHELL TO RUN THE NEXT COMMAND -"
sleep 3

docker run \
  --network=${NETWORK} \
  --cap-add IPC_LOCK \
  -p 8200:8200 \
  -e "VAULT_DEV_ROOT_TOKEN_ID=${VAULT_DEV_ROOT_TOKEN_ID}" \
  -e 'VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:8200' \
  -e NODE_TLS_REJECT_UNAUTHORIZED=$NODE_TLS_REJECT_UNAUTHORIZED \
  --restart unless-stopped \
  --name $NAME \
  vault
