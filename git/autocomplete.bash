function _gwr_complete {
    local lines=$(git worktree list --porcelain | grep '^worktree' | awk '{print $2}' | tail -n +2)
    IFS=$'\n'
    COMREPLY=()
    for line in $lines; do
        COMPREPLY+=("$line")
    done
}
complete -F _gwr_complete gwr
