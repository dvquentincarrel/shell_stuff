#!/bin/bash
# Setup script, handles symlink creation

args=(-s -i)
# If -n as first arg, don't ask to replace
[[ "$1" == "-n" ]] && shift && unset 'args[1]'

lbin=${1:-"$HOME/.local/bin"}
mkdir -p "$lbin"
for executable in \
        aliases.sh auto_tmux init_func LESS_TERMCAP \
        ls_colors notmux readline_keybinds \
        sh_setup variables.sh nnn_config \
        dense_roach; do
    ln ${args[@]} "$PWD/$executable" "$lbin/$executable"
done

for dotfile in tmux.conf bashrc \
        gitconfig profile inputrc alacritty.yml \
        gitconfig-etu gitconfig-work; do
    ln ${args[@]}  "$PWD/$dotfile" "$HOME/.$dotfile"
done

ignorepath="$HOME/.config/git"
mkdir -p "$ignorepath"
ln ${args[@]} "$PWD/gitignore" "$ignorepath/ignore"
