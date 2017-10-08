#!/bin/bash

docker stop $(docker ps -a -f name=vault-server -q)
docker rm $(docker ps -a -f name=vault-server -q)
