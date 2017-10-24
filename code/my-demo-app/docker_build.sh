#!/bin/bash

export GIT_ROOT=$(git rev-parse --show-toplevel)
export IMG_NAME='3jmaster/addo-demo-app'

echo -e ""
echo -e " _|  _   _ |   _  ._   |_      o |  _| "
echo -e "(_| (_) (_ |< (/_ |    |_) |_| | | (_| "
echo -e ""

docker build -t ${IMG_NAME} ${GIT_ROOT}/code/my-demo-app/.
