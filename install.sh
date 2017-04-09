#!/bin/bash

set -ex

SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${HOME}
for CF in hammerspoon tmux.conf;  do {
  ln -sf ${SOURCE}/${CF} .${CF} ;
}; done

SOURCE_PROFILE=${SOURCE}/profile.d/profile
if [[ $(uname) =~ "Darwin" ]] ; then
  ln -sf ${SOURCE_PROFILE} ~/.profile
else
  ln -sf ${SOURCE_PROFILE} ~/.bash_profile
fi
