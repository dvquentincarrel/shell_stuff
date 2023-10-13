# Setups the bash/zsh session
# Is re-sourced on `Reload`
source variables
source aliases
source init_func
source LESS_TERMCAP # less's config file
source ls_colors
source nnn_config
# fzf part
source env_vars
source functions

if ! grep -q '\bshare_hist\b' <<< $PROMPT_COMMAND ; then
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;} share_hist"
fi
