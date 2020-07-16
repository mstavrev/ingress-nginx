#!/bin/bash

set -e

export DOCKER_CLI_EXPERIMENTAL=enabled

# Build the nginx (web server) image itself first:
cd images/nginx
make push

# Build the nginx-ingress image:
cd ../..
make release
