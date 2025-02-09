# Absolute melting pot of functions and utilities

function th {
    if [[ $HISTFILE = /dev/null ]]; then
        echo 'History enabled'
        export HISTFILE="$_OLD_HISTFILE"
    else
        _OLD_HISTFILE="$HISTFILE"
        export HISTFILE=/dev/null
        echo 'History disabled'
    fi
}
export -f th

function mcd {
    # Makes + cd
    mkdir -p "$1" && cd "$1"
}
export -f mcd

function fcd {
    # Follows a symbolic link to its parent directory
    file=$(readlink "$1")
    if [ -d "$file" ]; then
        cd "$file"
    else
        cd $(dirname "$file")
    fi
}
export -f fcd

function proc {
    # Returns infos about processes with a matching name
    ps axo user,pid,ppid,%cpu,%mem,vsz,rss,tty,stat,start,time,command | \
        grep --color=always -Pi "$1|STAT +START" | head -n-1
    }
    export -f proc

    function del_pkg {
        # gives information about a package and asks for deletion. pacman-specific
        local OPTIND opt
        while getopts "h" opt; do
            case $opt in
                h) 	echo 'Prints info about package, asks for removal of it and dependancies installed with it'
                    echo 'sudo pacman -Qi $1 | /bin/grep -E "(Name|Description|Depends|Required|Reason)" && sudo pacman -Rs $1'
                    return 0;;
            esac
        done
        shift $((OPTIND -1))
        sudo pacman -Qi $1 | /bin/grep -E "(Name|Description|Depends|Required|Reason)" && sudo pacman -Rs $1
    }
    export -f del_pkg

    ex () {
        # decompresses file automatically using the right tool
        if [ -f $1 ] ; then
            case $1 in
                *.bz2)  bunzip2 $1   ;;
                *.rar)  unrar x $1   ;;
                *.gz)   gunzip $1    ;;
                *.zip)  unzip $1     ;;
                *.Z)    uncompress $1;;
                *.7z)   7z x $1      ;;
                *.tar | *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz) tar xf $1;;
                *)           echo "'$1' cannot be extracted via ex()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
    }

    function galias {
        alias | cut -d' ' -f 2- | grep $1 | perl -pe 's/^(.*?)=/\e[1;33m\1\e[0m: /;'
    }
    export -f galias
    complete -A alias galias

# File CLip - puts absolute path of file passed as arg in clipboard
function fcl {
    local OPTIND
    while getopts "hu" opt; do
        case $opt in
            h)  echo "Usage: fcl [-u] FILE..."
                echo "Puts absolute path to file (or url with -u) in clipboard"
                return 0;;
            u)  local PREFIX="file://";;
            *)  echo "invalid option '$opt'"
                return 1;;
        esac
    done
    shift $((OPTIND -1))
    if [[ $# -eq 0 ]]; then
        echo "Usage: fcl [-u] FILE"; return 1
    fi

    paths=()
    for file in "$@"; do
        paths+=("${PREFIX}$(readlink -f "$file")")
    done

    if [[ $XDG_SESSION_TYPE = wayland ]]; then
        wl-copy "${paths[@]}"
    else
        tr -d '\n' | xclip -sel clip
    fi

    sed -e 's/^/\x1b[1;96m/' -e 's/$/\x1b[m sent to clipboard/' <<< "${paths[@]}"
}
export -f fcl

# Easier to remember than history -n
function sync_hist {
    history -n
}
export -f sync_hist

# Search for options in man pages
function gman {
    # TODO: just see about generating autocmpletion for it, pre-processing the man page to extract the options
    case $# in
        0)
            return 1;;
        1)
            # Command to be given to less, as man's pager. Only displays lines matching the pattern
            local command='+&^ *-(\w|-\w+)';;
        *)
            local matchedLines=$(man -P cat "$1" | grep -noP "^ *--?$2")
            local matchesNum=$(wc -l <<< $matchedLines)
            echo ${#matchedLines}
            if [[ $matchesNum -eq 0 ]] || [[ ${#matchedLines} -eq 0 ]]; then
                local command='+&^ *-(\w|-\w+)'
                # Only a single line matched, just open at its position
            elif [[ $matchesNum -eq 1 ]]; then
                local lineNum=$(cut -d: -f1 <<< $matchedLines)
                local command="+$lineNum"
            else
                local command="+&^ *--?$2"
                fi;;
        esac
        man -P "less -j1 '$command'" "$1"
    }
    export -f gman

# Reload some of all or the bash config
function reload {
    local help_msg opt OPTIND RELOAD_ALL=false VERBOSE=false
    read -d '' help_msg <<-"EOF"
	\\x1b[1mUsage\\x1b[m: reload [OPTION]
	Reloads the bash config setup (only $XDG_CONFIG_HOME/bash/setup/* by default)
	-h    Displays this message
	-a    Resources bashrc
	-v    Verbose
	EOF
    while getopts "hav" opt; do
        case $opt in
            h)  echo -e "$help_msg";;
            a)  RELOAD_ALL=true;;
            v)  VERBOSE=true;;
            *)  echo "invalid option '$opt'"
                return 1;;
        esac
    done
    shift $((OPTIND -1))

    if $RELOAD_ALL; then
        source "$HOME/.bashrc"
        return 0
    fi

    for file in $(echo $XDG_CONFIG_HOME/bash/setup/*); do
        $VERBOSE && echo "Sourcing $file"
        source $file
    done
}
export -f reload

function join_by {
    local d=${1-} f=${2-}
    if shift 2; then
        printf %s "$f" "${@/#/$d}"
    else
        echo "join_by needs at least 2 args"
        exit 1
    fi
}
export -f join_by

# vim: ft=bash
