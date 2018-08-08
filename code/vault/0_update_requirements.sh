#!/bin/bash

echo "Setup Vault"

# Make sure to have docker and vault on your system before proceeding
command -v docker >/dev/null 2>&1 || { echo >&2 "I require docker but it's not installed.  Aborting. See https://docker.com"; exit 1; }
command -v vault >/dev/null 2>&1 || { echo >&2 "I require vault but it's not installed.  Aborting. See https://vaultproject.io"; exit 1; }

# Get latest docker images
docker pull vault

# Set docker environment, networks, etc
docker network create --driver bridge isolated_nw

echo -e "\nRemember to set environment variables before running the rest of the scripts:"
echo -e "VAULT_ADDR, VAULT_DEV_ROOT_TOKEN_ID, VAULT_USERNAME, VAULT_PASSWORD"
