#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APT_GET='sudo apt-get -y'
VIM_SRC=$HOME/vim_src

$APT_GET update 
$APT_GET upgrade
$APT_GET install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev mercurial
$APT_GET remove vim-tiny vim-common vim-gui-common

hg clone https://code.google.com/p/vim/ $VIM_SRC
cd $VIM_SRC
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install
rm -rf $VIM_SRC
