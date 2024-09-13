function _gwr_complete {
    local lines=$(git worktree list --porcelain | grep '^worktree' | awk '{print $2}' | tail -n +2)
    IFS=$'\n'
    COMREPLY=()
    for line in $lines; do
        COMPREPLY+=("$line")
    done
}
complete -F _gwr_complete gwr

function _gct_complete {
    refs=$(git show-ref | cut -f 2 -d' ' | sed -e 's;refs/\w\+/;;')
    COMPREPLY=($(compgen -W "$refs" -- $2))
}
complete -F _gct_complete gct
