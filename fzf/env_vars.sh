export FZF_DEFAULT_OPTS='
--height 50%
--bind
    "ctrl-v:execute(vim {})","ctrl-d:execute(dragon {+})","ctrl-e:preview-down","ctrl-y:preview-up"
--ansi
--preview="$(which bat batcat false 2>/dev/null | head -n1) -p -r :50 --color=always {} || head -n 50 {}"
--multi
--reverse
'
