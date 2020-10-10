# this function has to load _after_ ~/.config/fish/conf.d/omf.fish, hence the goofy name for this file

# function fish_title
#   set PROFILE default
#   set -q AWS_PROFILE && set PROFILE $AWS_PROFILE
#   set KUBE default
#   set -q KUBECONFIG && set KUBE (basename $KUBECONFIG)
#   echo "$PROFILE/$KUBE"
# end

# the default is some kind of right-caret, no likey
set -g theme_newline_prompt '$ '
set -g theme_newline_cursor yes
# disable abbreviating directory names, since we get a newline anyway
set -g fish_prompt_pwd_dir_length 0

# all this virtualenv stuff, oy
set -x PYENV_ROOT $HOME/.pyenv
# _don't_ set this, the PS1 changes work if you source the relevant `activate.fish`
# set -g VIRTUAL_ENV_DISABLE_PROMPT 1
set -g theme_display_virtualenv no  # leaves the activate-provided prompt
# now you need a function to activate virtualenvs
function pyact
  set -l env_name $argv[1]
  # cat $PYENV_ROOT/versions/$env_name/bin/activate.fish | source
  source $PYENV_ROOT/versions/$env_name/bin/activate.fish
end

# from the pyenv instructions
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source


function fish_right_prompt; end  # diable the right (timestamp) prompt

# use this as a workaround if you don't have a powerline font installed
# set -g theme_powerline_fonts no

# turning all these off might speed up your prompt a teeny bit
set -g theme_display_vagrant no
set -g theme_display_docker_machine no
set -g theme_display_k8s_context no
set -g theme_display_hg no
set -g theme_display_virtualenv no
set -g theme_display_nix no
set -g theme_display_ruby no
set -g theme_display_nvm no
set -g theme_display_vi no
set -g theme_display_date no
