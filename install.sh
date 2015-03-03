#!/bin/sh

link_if_missing() {
    SRC=$1
    DEST=$2

    if ! [ -L $DEST ]; then
        ln -ivs $SRC $DEST
    else
        echo "Skipping, link already exists: $DEST"
    fi
}

link_if_missing $PWD/.vimrc $HOME/.vimrc
link_if_missing $PWD/.vim $HOME/.vim
link_if_missing $PWD/.bashrc $HOME/.bashrc
