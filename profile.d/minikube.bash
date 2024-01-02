
if [ $(docker info > /dev/null 2>&1) ] ; then
  echo "docker not running"
else
  if eval "$(minikube -p minikube docker-env 2>/dev/null)"; then
    true
  else
    echo "minikube not running. Run \$(minikube -p minikube docker-env) to enable all the things." 1>&2
  fi
fi

alias k='kubectl '
export KUBECONFIG=~/.kube/minikube
# shellcheck disable=SC1090
source <(kubectl completion bash)
complete -F __start_kubectl k
