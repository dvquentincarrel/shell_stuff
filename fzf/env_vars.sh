export FZF_DEFAULT_OPTS='
--height 50%
--bind "ctrl-e:execute($EDITOR {})"
--bind "ctrl-d:execute(dragon {+})"
--bind "alt-down:preview-down"
--bind "alt-up:preview-up"
--bind "ctrl-p:toggle-preview"
--ansi
--preview="fzf_preview.bash {}"
--multi
--reverse
--color "hl:#FFAA00,hl+:#FFAA00"
'
