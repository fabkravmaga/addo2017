#!/bin/bash
docker stop $(docker ps -a -f name=vault-ui -q)
docker rm $(docker ps -a -f name=vault-ui -q)
docker stop $(docker ps -a -f name=vault-server -q)
docker rm $(docker ps -a -f name=vault-server -q)
