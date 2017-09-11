#!/bin/bash

echo "Setup Vaults"

# Make sure to have docker on your system before proceeding
command -v docker

# Get latest docker images
docker pull vault
docker pull djenriquez/vault-ui


# Set docker environment, networks, etc
