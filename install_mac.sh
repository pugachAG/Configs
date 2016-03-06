#!/bin/bash

git submodule update --init --recursive
./lenaps configure
cp ./lenaps /usr/local/bin/
cp ./mac_clip/clip_serv.py /usr/local/bin/

