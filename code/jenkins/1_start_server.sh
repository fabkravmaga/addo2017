#!/bin/bash

NAME='jenkins-server'
NETWORK='isolated_nw'

echo -e "- This runs in detached mode -"

docker run \
  -d \
  --network=${NETWORK} \
  -p 8080:8080 \
  -p 50000:50000 \
  --restart unless-stopped \
  -v jenkins_home:/var/jenkins_home \
  --name ${NAME} \
  jenkins/jenkins:lts
