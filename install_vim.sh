#!/bin/bash

APT_GET='sudo apt-get -y'
VIM_SRC=$HOME/vim_src

$APT_GET update 
$APT_GET upgrade
$APT_GET install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev git 
$APT_GET remove vim vim-runtime gvim vim-tiny vim-common vim-gui-common

git clone https://github.com/vim/vim.git $VIM_SRC

cd $VIM_SRC
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make
sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
rm -rf $VIM_SRC
