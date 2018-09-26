#!/bin/bash

# Make sure to have vault on your system before proceeding
command -v vault >/dev/null 2>&1 || { echo >&2 "I require vault but it's not installed.  Aborting."; exit 1; }
command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it's not installed.  Aborting."; exit 1; }

: "${VAULT_ADDR?Need to set your VAULT_ADDR, usually 'export VAULT_ADDR=http://127.0.0.1:8200'}"
: "${VAULT_DEV_ROOT_TOKEN_ID?Need to set your VAULT_DEV_ROOT_TOKEN_ID}"

ORGANIZATION='DevSecOpsSG'

# login to vault as root to set up
vault login ${VAULT_DEV_ROOT_TOKEN_ID}

vault auth enable github

vault write auth/github/config organization=$ORGANIZATION
vault write auth/github/map/teams/admin value=vault_admin
