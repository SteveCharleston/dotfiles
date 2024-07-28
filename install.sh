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
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/fusuma
chmod 0755 $HOME/bin

link_if_missing $PWD/.vimrc $HOME/.vimrc
link_if_missing $PWD/.vim $HOME/.vim
link_if_missing $PWD/.bashrc $HOME/.bashrc
link_if_missing $PWD/.tmux.conf $HOME/.tmux.conf
link_if_missing $PWD/.minttyrc $HOME/.minttyrc
link_if_missing $PWD/.ideavimrc $HOME/.ideavimrc
link_if_missing $PWD/.coc-settings.json $HOME/.config/nvim/coc-settings.json
link_if_missing $PWD/.coc-settings.json $HOME/.vim/coc-settings.json
link_if_missing $PWD/.chromaterm.yml $HOME/.chromaterm.yml
link_if_missing $PWD/.comfortable-swipe.conf $HOME/.config/comfortable-swipe.conf
link_if_missing $PWD/.fusuma_config $HOME/.config/fusuma/config.yml

link_if_missing $PWD/bin/mytree.py $HOME/bin/tree
chmod 0755 $HOME/bin/tree

# tmux plugins
mkdir -p ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
