#!/bin/bash

DEFAULT_USER=pugachag
USER_HOME=/home/$DEFAULT_USER

APT_GET='apt-get -y'
VIM_SRC=/tmp/vim_src
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


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
    aptget_install_pkgs git build-essential cmake tmux python zsh wget
    wget https://bootstrap.pypa.io/get-pip.py
    python get-pip.py
    rm get-pip.py
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
    cd /
    rm -rf $VIM_SRC
}

configure_vim() {
    su $DEFAULT_USER -c "cp -r $CURRENT_DIR/.vim $USER_HOME"
}

try_create_user() {
    if id -u "$DEFAULT_USER" >/dev/null 2>&1; then
        echo "User $DEFAULT_USER exists"
    else
        echo "Creating user $DEFAULT_USER"
        useradd -g sudo -m $DEFAULT_USER 
    fi
}

configure_user() {
    chsh -s /bin/zsh $DEFAULT_USER
}

# Main
git submodule update --init --recursive
try_create_user
aptget_update_upgrade
install_basic
install_vim
configure_vim
configure_user
