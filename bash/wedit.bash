#!/bin/bash
# wedit, Which EDIT

funcviewer=$(command -v bat && echo -l bash || echo cat)
aliasviewer=$(command -v galias || echo 'alias | grep')

if [[ $# -eq 0 ]] || [[ "$1" == "-h" ]]; then
    echo "Usage: wedit COMMAND [EDITOR] [EDITOR_OPTS]"
    echo 'Takes a command as an arg. If it is a script, opens it with $EDITOR if no editor is specified'
    [[ $# -eq 0 ]] && exit 1 || exit 0
fi

# Try to display info about input if it can't be easily edited
case $(type -t "$1") in
    'builtin')
        help "$1"
        exit 1;;
esac

if [[ -z "$EDITOR" ]] && [[ $# -lt 2 ]]; then
    echo 'No default editor in $EDITOR. You need to specify one'
    exit 1
fi

if [[ $# -gt 1 ]]; then
    if ! which "$2" &>/dev/null; then
        echo "$2 is not a valid executable file"
        exit 1
    else
        EDITOR="$2"
		EDITOR_OPTS="${@:3}"
    fi
fi

usr_command=$(which "$1" | head -n1 | xargs readlink -f 2>/dev/null)
if [[ -z "$usr_command" ]]; then
    # Last ditch effort to find aliases or functions
    output=$(bash -ic "
    shopt -s extdebug
    case \$(type -t "$1") in
        'alias')
            declare -F "$1"
            # TODO: display its content, at least
            exit 0;;
        'function')
            declare -F "$1"
            exit 0;;
    esac
    exit 1" 2>/dev/null | tail -n1)
    if [[ -z $output ]];then
        echo "Nothing found for '$1'"
        exit 1
    fi

    infos=($output)
    $EDITOR ${infos[2]} +${infos[1]}
    exit 0
fi

if file --mime "$usr_command" | grep 'charset=binary' >/dev/null; then
	read -p "$1 looks like a binary file. Are you sure you want to edit it? (y/any): " ans
	if [[ "$ans" != 'y' ]]; then
		exit 0
	fi
fi

$EDITOR $EDITOR_OPTS "$usr_command"
