#!/bin/bash

git submodule update --init --recursive
./lenaps configure
cp ./lenaps /usr/local/bin/

