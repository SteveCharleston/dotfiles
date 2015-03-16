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

mkdir -p $HOME/bin
chmod 0755 $HOME/bin

link_if_missing $PWD/.vimrc $HOME/.vimrc
link_if_missing $PWD/.vim $HOME/.vim
link_if_missing $PWD/.bashrc $HOME/.bashrc
link_if_missing $PWD/.tmux.conf $HOME/.tmux.conf
link_if_missing $PWD/.minttyrc $HOME/.minttyrc

link_if_missing $PWD/bin/mytree.py $HOME/bin/tree
chmod 0755 $HOME/bin/tree
