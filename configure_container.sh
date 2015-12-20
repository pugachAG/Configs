#!/bin/bash

DEFAULT_USER=pugachag
DEFAULT_PASS=Zaa123
USER_HOME=/home/$DEFAULT_USER

APT_GET='apt-get -y'
VIM_SRC=/tmp/vim_src
CURRENT_DIR=/tmp/config

aptget_remove_pkgs() {
    for pkg in "$@"
    do
        echo "Trying to remove $pkg package..."
        $APT_GET purge $pkg
    done
}

aptget_install_pkgs() {
    for pkg in "$@"
    do
        echo "Trying to isntall $pkg package..."
        $APT_GET install $pkg
    done
}

aptget_update_upgrade() {
    $APT_GET update && $APT_GET upgrade
}

install_basic() {
    aptget_install_pkgs git build-essential cmake tmux python
}

install_vim() {
    aptget_install_pkgs libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev
    aptget_remove_pkgs vim vim-runtime gvim vim-tiny vim-common vim-gui-common
    rm /usr/bin/vim

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

configure_vim() {
    su $DEFAULT_USER -c "cp -r $CURRENT_DIR/.vim $USER_HOME"
}

create_user() {
    echo "Creating user $DEFAULT_USER with password $DEFAULT_PASS"
    useradd -g sudo -m pugachag && echo "$DEFAULT_USER:$DEFAULT_PASS" | chpasswd
}

# Main
create_user
aptget_update_upgrade
install_basic
install_vim
configure_vim
return 0
