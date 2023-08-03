# from `curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh`
[ -f ~/.bash-preexec.sh ] && source ~/.bash-preexec.sh
eval "$(/opt/homebrew/bin/atuin init bash --disable-up-arrow)"
