#!/bin/bash

NODE_TLS_REJECT_UNAUTHORIZED=1 # Set to 0 to disable TLS (ex. vault deployed with self-signed certificate)
NAME='vault-server'
NETWORK='isolated_nw'

: "${VAULT_DEV_ROOT_TOKEN_ID?Need to set your VAULT_DEV_ROOT_TOKEN_ID}"
: "${VAULT_USERNAME?Need to set your VAULT_USERNAME}"
: "${VAULT_PASSWORD?Need to set your VAULT_PASSWORD}"


echo -e "- This runs in detached mode so KEEP THIS SHELL RUNNING IN THE BACKGROUND -"
echo -e "- Press 'Ctrl + C' to KILL -"
echo -e "- OPEN A NEW SHELL to run the next command -"
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
