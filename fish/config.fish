#set -g theme_display_date no
set -g theme_newline_cursor yes
set -g fish_prompt_pwd_dir_length 0
set -g VIRTUAL_ENV_DISABLE_PROMPT 1

set -x PYENV_ROOT $HOME/.pyenv
#set -x PATH $PYENV_ROOT/bin $PATH

status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

