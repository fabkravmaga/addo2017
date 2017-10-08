#!/bin/bash

PWD=$(pwd)
docker build -t 3jmaster/addo-demo-app ${PWD}/my-demo-app/
