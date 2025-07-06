function th -d "Toggles history"
    if ! set -q fish_history
        set -g fish_history ''
    else
        set -eg fish_history
    end
end

function mcd -d "Make + cd"
    mkdir -p $argv[1] && cd $argv[1]
end

function fzd
    set help_msg "Usage: fzd
Use fzf & bf to select a directory"
	if test "$argv[1]" = '-h'
		echo "$help_msg"
		return 0
    end
    set path $(
		bf $argv | fzf --preview='tree -C {}'
	)
	if test -n "$path"
		pushd "$path"
    end
end

fzf --fish | source
