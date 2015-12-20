#!/bin/bash

git submodule update --init --recursive
./docker_util.sh build .
cp ./docker_util.sh /usr/local/bin/lenaps

