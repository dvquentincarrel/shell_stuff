if ! status --is-interactive
    return 0
end

# Enables / disables component
set -g __GIT true
set -g __GIT_STASH true
set -g __GIT_STATUS true
set -g __GIT_DIVERGENCE true

if $FANCY_COLORS
    set __GIT_C_STAGED "\x1b[38;5;40m"       # Green
    set __GIT_C_UNTRACKED "\x1b[38;5;197m"   # Red
    set __GIT_C_UNSTAGED "\x1b[38;5;166m"    # Orange
    set __GIT_C_UNMERGED "\x1b[38;5;213m"    # Pink
    set __GIT_C_AHEAD "\x1b[38;5;14m"        # Cyan
    set __GIT_C_BEHIND "\x1b[38;5;13m"       # Magenta
    set __GIT_C_BRANCH "\x1b[38;5;214m"      # yellow
    set __GIT_C_TAG "\x1b[38;5;205m"       # pale pink
    set __GIT_C_DETACH "\x1b[38;5;202m"      # dark orange
    set __GIT_C_BARE "\x1b[38;5;202m"        # dark orange
else
    set __GIT_C_STAGED "\x1b[32m"     # green
    set __GIT_C_UNTRACKED "\x1b[31m"  # red
    set __GIT_C_UNSTAGED "\x1b[33m"   # yellow
    set __GIT_C_UNMERGED "\x1b[35m"   # purple
    set __GIT_C_AHEAD "\x1b[36m"      # cyan
    set __GIT_C_BEHIND "\x1b[35m"     # purple
    set __GIT_C_BRANCH "\x1b[33m"     # yellow
    set __GIT_C_TAG "\x1b[35m"      # purple
    set __GIT_C_DETACH "\x1b[31m"     # red
    set __GIT_C_BARE "\x1b[31m"       # red
end

if $FANCY_SYMBOLS
    set __GIT_S_AHEAD "↑"
    set __GIT_S_BEHIND "↓"
else
    set __GIT_S_AHEAD "^"
    set __GIT_S_BEHIND "v"
end

function __git_prompt
    $__GIT || return 0
    test "$PWD" = "$HOME" && return 0
    begin; test -d .git || git rev-parse --show-toplevel &>/dev/null; end || return 0
    __print_ref
    $__GIT_STASH && __print_stash
    # Only print status for repos whose packs amount to less than 100MB. Not a
    # perfect metric, especially without running `git gc` first, but good enough
    # for a simple script
    if test $(git count-objects -v 2>/dev/null | awk '/size-pack/ {print $2}') -lt 100000
        $__GIT_STATUS && __print_status
    end
    $__GIT_DIVERGENCE && __print_divergence
end

function __print_ref
    set rev $(git tag --points-at HEAD 2>/dev/null | tail -n 1)
    set type tag
    if test -z "$rev"
        set rev  $(git branch --show-current)
        set type branch
        if test -z "$rev"
            set rev $(git rev-parse --short HEAD)
            set type sha
        end
    end
    switch "$type"
        case tag
            set rev "$__GIT_C_TAG$rev"
        case branch
            set rev "$__GIT_C_BRANCH$rev"
        case sha
            set rev "$__GIT_C_DETACH$rev"
    end
    printf "%s" "$rev"
end

function __print_status
    set output $(
    git status --porcelain --branch |
    awk \
        -v staged_clr="$__GIT_C_STAGED"\
        -v unstaged_clr="$__GIT_C_UNSTAGED"\
        -v untracked_clr="$__GIT_C_UNTRACKED"\
        -v unmerged_clr="$__GIT_C_UNMERGED"\
        -v separator="$__delim"\
    '{
        if($RT ~ /^\?\?/)
            untracked+=1;
        else
            if($RT ~ /^( .|MM)/)
                unstaged+=1;
            if($RT ~ /^(. |MM)/)
                staged+=1;
            if($RT ~ /^(D[DU]\|U[ADU]\|A[AU])/)
                unmerged+=1;

    } END {
        if(staged)
            printf("%s%s+", staged_clr, staged)
        if(unstaged)
            printf("%s%s!", unstaged_clr, unstaged)
        if(untracked)
            printf("%s%s?", untracked_clr, untracked)
        if(unmerged)
            printf("%s%s#", unmerged_clr, unmerged)
        if(length(behind) != 0 || length(ahead) != 0 )
            if(staged + unstaged + untracked + unmerged != 0) {
                printf(separator)
            }
            printf("%s%s", ahead, behind)
        }')
        if test -n "$output"
            printf "%s%s" $__delim $output
        end
end

function __print_stash
    set output $(git stash list | wc -l)
    if test "$output" != 0
        echo -n "$__delim\e[90ms$output"
    end
end

function __print_divergence
    set output $(
        git rev-list --count --left-right @...@{u} 2>/dev/null |
        awk \
        -v ahead_sym="$__GIT_S_AHEAD"\
        -v behind_sym="$__GIT_S_BEHIND"\
        -v ahead_clr="$__GIT_C_AHEAD"\
        -v behind_clr="$__GIT_C_BEHIND"\
        '/^[0-9]+\t[0-9]+$/ {
        if($1 != 0)
            printf("%s%s%s", ahead_clr, $1, ahead_sym)
        if($2 != 0)
            printf("%s%s%s", behind_clr, $2, behind_sym)
        }'
    )
    if test -n "$output"
        printf (string join '' $__delim $output)
    end
end
