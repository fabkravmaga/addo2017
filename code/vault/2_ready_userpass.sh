#!/bin/bash

# Make sure to have vault on your system before proceeding
command -v vault >/dev/null 2>&1 || { echo >&2 "I require vault but it's not installed.  Aborting."; exit 1; }
command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it's not installed.  Aborting."; exit 1; }

: "${VAULT_ADDR?Need to set your VAULT_ADDR, usually 'export VAULT_ADDR=http://127.0.0.1:8200'}"
: "${VAULT_DEV_ROOT_TOKEN_ID?Need to set your VAULT_DEV_ROOT_TOKEN_ID}"
: "${VAULT_USERNAME?Need to set your VAULT_USERNAME}"
: "${VAULT_PASSWORD?Need to set your VAULT_PASSWORD}"

# login to vault as root to set up
vault auth ${VAULT_DEV_ROOT_TOKEN_ID}

# enable audit log !
vault audit-enable file file_path=/tmp/audit.log

# write the policy into vault
vault policy-write vault_admin ./policies/vault_admin.hcl

# enable auth methods
vault auth-enable userpass
vault auth-enable approle

# make a new user based on the values defined in the .secret0 file
vault write auth/userpass/users/${VAULT_USERNAME} policies=vault_admin password=${VAULT_PASSWORD}

# login to vault as new user
vault auth -method=userpass username=${VAULT_USERNAME} password=${VAULT_PASSWORD}
vault token-lookup

# Always revoke tokens for testing and printing out on screen
# TOKEN=$(vault token-lookup -format=json | jq -r .data.id)
# vault token-revoke ${TOKEN}
