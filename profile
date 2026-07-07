# shellcheck shell=bash
DIR=$(dirname "$(readlink "${BASH_SOURCE[0]}")")

for FILE in "${DIR}"/profile.d/*.bash ; do {
# shellcheck disable=SC1090
  . "${FILE}"
} ; done

export PATH=$PATH:${HOME}/bin
