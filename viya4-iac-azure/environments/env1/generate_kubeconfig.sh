#!/bin/bash
# NOTE: Execute within environment working directory

# Remove config output from IAC process so Azure CLI output is cleaner
rm XXXXXXXXX-aks-kubeconfig.conf

az aks get-credentials --resource-group XXXXXXXXX-rg --name XXXXXXXXX-aks --file XXXXXXXXX-aks-kubeconfig.conf --overwrite-existing

chmod 700 XXXXXXXXX-aks-kubeconfig.conf
