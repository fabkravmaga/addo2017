#!/bin/bash

echo "Setup Jenkins"

# Get latest docker images
docker pull jenkins/jenkins:lts

# Set docker environment, networks, etc
docker network create --driver bridge isolated_nw
