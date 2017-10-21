#!/bin/bash

PWD=$(pwd)
source ${PWD}/.secret0

rm -f nohup.out
touch nohup.out
tail -f nohup.out &

# Shutdown all first
nohup bash 99_shutdown_all.sh

# Start all script in sequence
nohup bash 1_start_server.sh &
sleep 5
nohup bash 2_ready_userpass.sh
nohup bash 3_ready_approle.sh
nohup bash 4_test_approle.sh
nohup bash 5_start_ui.sh
