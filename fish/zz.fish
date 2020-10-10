# this function has to load _after_ ~/.config/fish/conf.d/omf.fish, hence the goofy name for this file

function fish_title
  set PROFILE default
  set -q AWS_PROFILE && set PROFILE $AWS_PROFILE
  set KUBE default
  set -q KUBECONFIG && set KUBE (basename $KUBECONFIG)
  echo "$PROFILE/$KUBE"
end
