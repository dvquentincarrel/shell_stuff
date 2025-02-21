for file in ~/.config/profile/*sh; do
    . "$file" 2>/dev/null # Errs out if no file is found, glob expr is returned as literal
done

export XDG_DATA_DIRS=${XDG_DATA_DIRS:-"/usr/local/share:/usr/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if grep -v "$HOME/.local/bin" <<< "$PATH" &> /dev/null; then
    export PATH=$HOME/.local/bin:$PATH
fi
