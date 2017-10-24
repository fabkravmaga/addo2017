#!/bin/bash

bash ./docker_build.sh
bash ./docker_stop_rm_app.sh
bash ./docker_run.sh
