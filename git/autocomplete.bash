function _gwr_complete {
    local candidates=$(git worktree list --porcelain | awk '/^worktree/ && NR>1 {print $2}')
    COMPREPLY=($(compgen -W "$candidates" -- $2))
}
complete -F _gwr_complete gwr

function _gct_complete {
    local refs=$(git show-ref | awk '{sub(/refs\/\w+\/?/, "", $2); if ($2) print $2}')
    COMPREPLY=($(compgen -W "$refs" -- $2))
}
complete -F _gct_complete gct
