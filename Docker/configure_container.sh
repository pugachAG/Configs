#!/bin/bash

APT_GET='apt-get -y'
VIM_SRC=/tmp/vim_src

remove_pkgs() {
    for pkg in "$@"
    do
        echo "Trying to remove $pkg package..."
        $APT_GET purge $pkg
    done
}

install_pkgs() {
    for pkg in "$@"
    do
        echo "Trying to isntall $pkg package..."
        $APT_GET install $pkg
    done
}

install_vim() {

install_pkgs libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev git 
remove_pkgs vim vim-runtime gvim vim-tiny vim-common vim-gui-common

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
make VIMRUNTIMEDIR=/usr/share/vim/vim74
make install
rm -rf $VIM_SRC
}

# Main
$APT_GET update && $APT_GET upgrade
return 0
