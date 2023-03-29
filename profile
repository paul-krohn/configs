DIR=$(dirname $BASH_SOURCE)

for FILE in $DIR/profile.d/*.bash ; do {
  . $FILE
} ; done

export PATH=$PATH:${HOME}/bin
