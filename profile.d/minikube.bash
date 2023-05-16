
eval "$(minikube -p minikube docker-env 2>/dev/null)"
if [ $? -eq 0 ] ; then
  alias k='kubectl '
else
  echo "docker or minikube not running. Run \$(minikube -p minikube docker-env) to enable all the things." 1>&2
fi

alias k='kubectl '
export KUBECONFIG=~/.kube/minikube
source <(kubectl completion bash)
complete -F __start_kubectl k
