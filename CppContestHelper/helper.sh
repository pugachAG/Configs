#!/bin/bash

APP_SOURCE_CODE_TEMPLATE="#include <bits/stdc++.h>

using namespace std;

int main()
{
}"
APP_SOURCE=main.cpp
APP_NAME=app
APP_OUTPUT=output.txt
APP_INPUT=input.txt
DELIM='-------------------------------------------'

FileRemoveIfExists() {
    if [ -f $1 ]
    then
        printf 'Removing %s...\n' $1
        rm $1
    fi
}

FileCreateIfAbsent() {
    if ! [ -f $1 ]
    then
        printf 'Creating %s...\n' $1
        touch $1
    fi
}

CreateIOFiles() {
    FileCreateIfAbsent $APP_INPUT
    FileCreateIfAbsent $APP_OUTPUT
}


DoRunApp() {
    if ! [ -f $APP_SOURCE ]
    then
        printf 'Missing source code file %s!\n' $APP_SOURCE
        return
    fi
    CreateIOFiles
    FileRemoveIfExists $APP_NAME
    printf 'Building %s...\n' $APP_NAME 
    c++ -std=c++11  $APP_SOURCE -o $APP_NAME
    if [ -f $APP_NAME ]
    then
        printf 'Running %s...\n' $APP_NAME 
        ./$APP_NAME < $APP_INPUT > $APP_OUTPUT 
        printf '%s stdout:\n' $APP_NAME 
        printf '%s\n' $DELIM 
        cat $APP_OUTPUT 
        printf '\n%s\n' $DELIM 
    fi
}

DoClear() {
    FileRemoveIfExists $APP_NAME
    FileRemoveIfExists $APP_INPUT
    FileRemoveIfExists $APP_OUTPUT
    FileRemoveIfExists $APP_SOURCE
}

DoCreate() {
    CreateIOFiles
    if [ -f $APP_SOURCE ]
    then
        printf 'Source code file %s already exists ...\n' $APP_SOURCE
    else
        FileCreateIfAbsent $APP_SOURCE
        echo "$APP_SOURCE_CODE_TEMPLATE" > $APP_SOURCE
    fi
}

DoReset() {
    DoClear
    DoCreate
}

DoOpen() {
    vim -O $APP_SOURCE $APP_INPUT
}

case $1 in
    -run|'')
        DoRunApp
        ;;
    -clear)
        DoClear
        ;;
    -create)
        DoCreate
        ;;
    -reset)
        DoReset
        ;;
    -open)
        DoOpen
        ;;
    *)
        printf '%s: Unknown command\n' "$1" 
        ;;
esac
