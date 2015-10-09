#!/bin/bash

APT_GET='sudo apt-get -y'
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VIM_DIR=$CURRENT_DIR/.vim

$APT_GET install git cmake
cd $CURRENT_DIR
git submodule update --init --recursive
cp -r $VIM_DIR $HOME
vim +PluginInstall +qall
cd $HOME/.vim/bundle/YouCompleteMe
sudo python2 ./install.py --clang-completer
cp $CURRENT_DIR/.ycm_extra_conf.py $HOME
