#!/bin/bash

export DOCKER_CLI_EXPERIMENTAL=enabled

make build && make container && make push

