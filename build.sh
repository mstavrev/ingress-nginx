#!/bin/bash

set -e

export DOCKER_CLI_EXPERIMENTAL=enabled

# Build the nginx (web server) image itslef first:
cd images/nginx
make container && make push

# Build the nginx-ingress image:
cd ../..
make build && make container && make push
