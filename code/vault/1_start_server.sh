#!/bin/bash

NODE_TLS_REJECT_UNAUTHORIZED=1 # Set to 0 to disable TLS (ex. vault deployed with self-signed certificate)
NAME='vault-server'
NETWORK='isolated_nw'

# : "${VAULT_DEV_ROOT_TOKEN_ID?Need to set your VAULT_DEV_ROOT_TOKEN_ID}"
# : "${VAULT_USERNAME?Need to set your VAULT_USERNAME}"
# : "${VAULT_PASSWORD?Need to set your VAULT_PASSWORD}"

echo -e "- This runs in detached mode -"

# At startup, the server will read configuration HCL and JSON files from /vault/config
# any information passed into VAULT_LOCAL_CONFIG is written into local.json in this directory
# and read as part of reading the directory for configuration files).
# Please see Vault's configuration documentation for a full list of options.

# -e 'VAULT_LOCAL_CONFIG={"backend": {"file": {"path": "/vault/file"}}, "default_lease_ttl": "168h", "max_lease_ttl": "720h"}' \

docker run \
  -d \
  --network=${NETWORK} \
  --cap-add IPC_LOCK \
  -p 8200:8200 \
  -e NODE_TLS_REJECT_UNAUTHORIZED=$NODE_TLS_REJECT_UNAUTHORIZED \
  --restart unless-stopped \
  --volume vault-file:/vault/file:Z \
  -v "$(pwd)"/vault-server.hcl:/vault/config/vault-server.hcl \
  --name $NAME \
  vault server
