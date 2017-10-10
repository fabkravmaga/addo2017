#!/bin/bash

IMG_NAME='3jmaster/addo-demo-app'
GIT_ROOT=$(git rev-parse --show-toplevel)
docker build -t ${IMG_NAME} ${GIT_ROOT}/code/my-demo-app/.
