# Absolute melting pot of functions and utilities

function th {
    if [[ -e $TMPDIR/bash_nohist ]]; then
        env rm "$TMPDIR/bash_nohist"
        printf '\x1b[32mhistory enabled\x1b[m\n' 1>&2
    else
        touch "$TMPDIR/bash_nohist"
        printf '\x1b[31mhistory disabled\x1b[m\n' 1>&2
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

function cdd {
	# cd + ls on arrival
	cd $1 && ls -l --color=auto
}
export -f cdd

function del_pkg {
	# gives information about a package and asks for deletion. pacman-specific
	reset_arg_opt
	while getopts "h" opt; do
		case $opt in
			h) 	echo 'Prints info about package, asks for removal of it and dependancies installed with it'
				echo 'sudo pacman -Qi $1 | /bin/grep -E "(Name|Description|Depends|Required|Reason)" && sudo pacman -Rs $1'
				return 0;;
		esac
	done
	shift $((OPTIND -1))
	reset_arg_opt
	sudo pacman -Qi $1 | /bin/grep -E "(Name|Description|Depends|Required|Reason)" && sudo pacman -Rs $1
}
export -f del_pkg

function xpr {
	# opens current (default) or specified dir using a file explorer
	# $1 : dir to open
	# $2 : file explorer to try to open the dir with
	reset_arg_opt
	while getopts "h" opt; do
	case $opt in

	esac
	done
	exp_path="${1:-.}"
	explorer="${2:-pcmanfm}"
    # TODO
	! (command -v $explorer &> /dev/null) && echo "$explorer is not a valid file explorer"
	if [ -d $exp_path ]; then
		($explorer $exp_path &) &> /dev/null
	else
		echo "$exp_path is not a directory"
	fi
	reset_arg_opt
}
export -f xpr

function reset_arg_opt {
	unset OPTIND
	unset opt
}
export -f reset_arg_opt

colors() {
	# Displays colors to test terminal
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc};${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals}};1mBOLD\e[m"
		done
		echo; echo
	done

	i=0
	printf "=== SRG [1,29] ===\n\n\t"
	for srg in {1..29}; do
		printf '\e[%bm%02d TEXT\e[m ' $srg $srg
		let i++
		(( $i % 10 == 0 )) && printf '\n\n\t'
	done

	printf '\n\n'

	i=0
	printf "=== SRG [50,107] ===\n\n\t"
	for srg in {50..107}; do
		printf '\e[%bm%03d TEXT\e[m ' $srg $srg
		let i++
		(( $i % 10 == 0 )) && printf '\n\n\t'
	done
	printf '\n\n'
}

ex () {
	# unzips file automatically using the right tool
	if [ -f $1 ] ; then
    	case $1 in
			*.tar.bz2)   tar xjf $1   ;;
	      	*.tar.gz)    tar xzf $1   ;;
		    *.bz2)       bunzip2 $1   ;;
		    *.rar)       unrar x $1   ;;
	      	*.gz)        gunzip $1    ;;
	      	*.tar)       tar xf $1    ;;
	      	*.tbz2)      tar xjf $1   ;;
	      	*.tgz)       tar xzf $1   ;;
	      	*.zip)       unzip $1     ;;
	      	*.Z)         uncompress $1;;
	      	*.7z)        7z x $1      ;;
      		*)           echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

function share_hist {
	$HSYNCW && history -a
	$HSYNCR && history -n
}
export -f share_hist

function empty_file_cache {
	sudo sysctl vm.drop_caches=3
}
export -f empty_file_cache

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
            h)  echo "Usage: fcl [-u] FILE"
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

    echo ${PREFIX}$(readlink -f "$@") | \
    tee \
        >(tr -d '\n' | xclip -sel clip) \
        >(sed -e 's/^/\x1b[1;96m/' -e 's/$/\x1b[m sent to clipboard/') \
        >/dev/null
}
export -f fcl

# Does something at the specified time, precise up to the second
function doat {
    if [[ $1 == '-h' ]] || [[ $# -lt 2 ]]; then
        echo 'Usage: doat HH:MM:SS COMMAND...'
        return
    fi
    while [[ $(date +%R:%S) < "$1" ]]; do
        sleep 1;
    done
	shift
    "$@"
}
export -f doat

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

# vim: ft=bash
