#!/bin/bash

set -e

while [ $# -gt 0 ]; do
  case "$1" in
    --image=*)
      image="${1#*=}"
      ;;
    --context=*)
      context="${1#*=}"
      ;;
    --environment=*)
      environment="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument.*\n"
      printf "***************************\n"
      exit 1
  esac
  shift
done

cd /src/overlays/${environment}
/kustomize edit set image image=${image}
/kustomize build > /tmp/output.yaml
printf "** Generated:\n"
cat /tmp/output.yaml
printf "** Applying\n"
/kubectl --context=${context} apply -f /tmp/output.yaml
printf "** Waiting for deployments\n"

deployments=`cat /tmp/output.yaml | yq 'if .kind == "Deployment" then .metadata.name else empty end' -r`
for deployment in $deployment; do
    set +e
    /kubectl rollout status deployment/${deployment}
    if [ $? ]; then
        /kubectl rollout undo deployment/${deployment}
    fi
    set -e
done

