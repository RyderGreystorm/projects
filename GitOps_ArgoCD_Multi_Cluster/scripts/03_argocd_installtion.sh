#!/bin/bash

# INSTALL ARGOCD ON HUB CLUSTER
# This file is used to install ArgoCD on your cluster, NOT TO INSTALL THE ARGOCD CLI \n\n To install argoCD CLI, RUN: brew install argocd for MAC OS
# For windows installation of ArgoCD CLI, please refer to the argo documentation at 'https://github.com/argoproj/argo-cd/releases/latest'

echo "WARNING!!! Refer to documentation on how to switch context to the hub cluster before running this script"
echo "For reference it is 'kubectl config use-context <cluster authid here>'"
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
