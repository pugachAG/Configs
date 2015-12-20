#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Configure plugins
vim +PluginInstall +qall
# YCM
cd $CURRENT_DIR/bundle/YouCompleteMe
python2 ./install.py #--clang-completer
#cp $CURRENT_DIR/.ycm_extra_conf.py $HOME
