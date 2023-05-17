# shellcheck shell=bash
DIR=$(dirname "${BASH_SOURCE}")

for FILE in "${DIR}"/profile.d/*.bash ; do {
# shellcheck disable=SC1090
  . "${FILE}"
} ; done

export PATH=$PATH:${HOME}/bin
