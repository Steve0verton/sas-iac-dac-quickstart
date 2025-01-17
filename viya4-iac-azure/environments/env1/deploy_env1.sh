#!/bin/bash
# NOTE: Execute within environment working directory

docker run --rm --group-add root \
  --user "$(id -u):$(id -g)" \
  --env-file=$HOME/azure-sp.env \
  --volume=$HOME/.ssh:/.ssh \
  --volume=$(pwd):/workspace \
  viya4-iac-azure \
  apply -auto-approve -parallelism=5 \
   -var-file=/workspace/env_abc.tfvars \
   -state=/workspace/env_abc.tfstate &> logs/deploy_$(date +"%FT%H%M").log
