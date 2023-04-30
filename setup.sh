#!/bin/bash
# Setup script, handles symlink creation

lbin=${1:-"$HOME/.local/bin"}
mkdir -p "$lbin"
for executable in \
        aliases.sh auto_tmux init_func LESS_TERMCAP \
        ls_colors notmux readline_keybinds \
        sh_setup variables.sh nnn_config; do
    ln -si "$PWD/$executable" "$lbin/$executable"
done

for dotfile in tmux.conf bashrc \
        gitconfig profile inputrc \
        gitconfig-etu gitconfig-work; do
    ln -si  "$PWD/$dotfile" "$HOME/.$dotfile"
done
