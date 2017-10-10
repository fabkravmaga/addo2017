#!/bin/bash

export GIT_ROOT=$(git rev-parse --show-toplevel)
export IMG_NAME='3jmaster/addo-demo-app'

docker build -t ${IMG_NAME} ${GIT_ROOT}/code/my-demo-app/.
