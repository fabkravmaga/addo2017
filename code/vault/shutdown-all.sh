#!/bin/bash
bash shutdown-server.sh
bash shutdown-ui.sh
docker ps -a
