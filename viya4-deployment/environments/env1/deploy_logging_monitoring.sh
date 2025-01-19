#!/bin/bash
# NOTE: Execute within environment working directory

docker run --rm \
	--group-add root \
	--user $(id -u):$(id -g) \
	--volume $(pwd):/data \
	--volume $HOME/deployments/viya4-iac-azure/environments/env1/env1-aks-kubeconfig.conf:/config/kubeconfig \
	--volume $HOME/deployments/viya4-deployment/environments/env1/env1.yaml:/config/config \
	--volume $HOME/deployments/viya4-iac-azure/environments/env1/env1.tfstate:/config/tfstate \
	--volume $HOME/.ssh/env1:/config/jump_svr_private_key \
	viya4-deployment --tags "cluster-logging,cluster-monitoring,viya-monitoring,install" -vvv >> logs/deploy_$(date +"%FT%H%M").log