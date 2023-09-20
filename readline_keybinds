#!/bin/bash

while getopts "h" opt; do
	case $opt in
		h) 	echo "Prints bash (readline) keybinds."
			exit 0;;
	esac
done
shift $((OPTIND -1)) 

echo "
MOVEMENT:
^A: Move to start of line@^E: Move to end of line
^F: Move forward a char@^B: Move backward a char
A-f: Move forward a word@A-b: Move backward a word
^XX: Moves between cursor and start of line
EDITION:
A-u: Capitalizes from cursor to end of word@A-l: Uncapitalizes from cursor to end of word
A-c: Capitalizes current character, moves to end of word
^K: Cuts from cursor to end of line@^K: Cuts from cursor to beginning of line
^W: Cuts previous word
^Y: Pastes previously cut text@A-y: Cycles through cutting buffer
^D: Delete current character@^_: Undo
A-^H: Backward kill word@A-T: Swap words
PROCESSES:
^C: Sends SIGINT to current process@^Z: Sends SIGTSTP to current process
^D: Sends EOF marker to bash
DISPLAY:
^S: Stops all output@^Q: Resumes all output
^L: Clears the screen
HISTORY:
^P: Go up in command history@^N: Go down in command history
A-r: Reverts change made to this history entry
^R: Attempts autocompletion from history@^O: Run autocompleted command
^G: Aborts autocompletion attempt" \
    | perl -pe 's/(^|@)(.*?):(?!$)/\1\e[1;33m\2\e[m:/g;'\
            -e 's/(^.*:$)/\e[1;4m\1\e[0m/' \
    | column -s"@" -t
#1;4m
#1;33m
