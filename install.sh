#!/bin/bash

set -ex

SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${HOME}
for CF in hammerspoon tmux.conf;  do {
  ln -sf ${SOURCE}/${CF} .${CF} ;
}; done

PROFILE_FILE="~/.bash_profile"
if [[ $(uname) =~ "Darwin" ]] ; then
  echo "on darwin, use .profile"
  PROFILE_FILE="~/.profile"
fi
ln -sf ${SOURCE}/profile.d/profile ${PROFILE_FILE}
