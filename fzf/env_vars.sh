export FZF_DEFAULT_OPTS='
--height 50%
--bind
    "ctrl-v:execute(vim {})","ctrl-d:execute(dragon {+})"
--ansi
--preview="$(which bat batcat false 2>/dev/null | head -n1) -p -r :50 --color=always {} || head -n 50 {}"
--multi
--reverse
'
