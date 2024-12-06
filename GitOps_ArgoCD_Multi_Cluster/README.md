# Multi-Cluster Kubernetes Deployment with ArgoCD

<div style="display: flex; justify-content: center; align-items: center; height: 100%; width: 100%;">
  <img src="https://cdn-images-1.medium.com/max/800/1*VwJwaclgHaYONwh-0ShBBg.gif" 
       alt="Coding Animation" 
       style="max-width: 100%; max-height: 100%; object-fit: contain;">
</div>

## Overview

This project demonstrates how to set up and manage **multi-cluster Kubernetes deployments** using **ArgoCD** in a **hub-and-spoke architecture**. The setup leverages **Amazon EKS** (Elastic Kubernetes Service) to create and manage four Kubernetes clusters, enabling streamlined application delivery across multiple clusters. 

With a focus on **GitOps practices**, this project showcases how ArgoCD ensures consistency between the desired state of your infrastructure (stored in Git) and the actual state of your Kubernetes clusters.

---

## Key Features

- **Multi-Cluster Architecture**: Hub-and-spoke design for managing multiple Kubernetes clusters.
- **Automated Deployments**: Leveraging ArgoCD to deploy and sync manifests across clusters.
- **Cross-Platform Support**: The setup scripts and documentation provide steps for any operating system.
- **GitOps Integration**: Centralized management of Kubernetes manifests stored in a Git repository.
- **Detailed Documentation**: Comprehensive guides to help you replicate the infrastructure.

---

## Tools and Technologies Used

- **Amazon EKS**: Managed Kubernetes service for deploying clusters.
- **ArgoCD**: GitOps tool for Kubernetes application deployment and management.
- **Chocolatey**: For managing local tools on Windows (optional).
- **kubectl**: CLI for Kubernetes management.
- **eksctl**: CLI for creating and managing EKS clusters.
- **GitHub**: Version control for storing Kubernetes manifests.

---

## Getting Started

### Prerequisites

1. **Kubernetes Tools**:
   - Install [kubectl](https://kubernetes.io/docs/tasks/tools/).
   - Install [eksctl](https://eksctl.io/introduction/#installation).
2. **ArgoCD CLI**:
   - Follow the [ArgoCD CLI installation guide](https://argo-cd.readthedocs.io/en/stable/cli_installation/).
3. **Git**:
   - Ensure Git is installed and configured.
4. **Access to AWS**:
   - Ensure you have AWS CLI installed and configured with appropriate permissions.

---

### Setup Guide

#### 1. Create EKS Clusters
Use **eksctl** to create four EKS clusters. The hub cluster serves as the ArgoCD central management plane, while the other three are spoke clusters.  
Refer to the [detailed setup guide](./docs/eks-setup.md) for step-by-step instructions.

#### 2. Install and Configure ArgoCD
- Deploy ArgoCD on the hub cluster.
- Connect spoke clusters using the ArgoCD CLI.

#### 3. Deploy Applications
Use the ArgoCD UI or CLI to deploy Kubernetes manifests to the clusters. The manifests are stored in the GitHub repository:  
[GitOps_ArgoCD_Multi_Cluster/app_manifests](https://github.com/RyderGreystorm/projects).

---

## How It Works

1. **Hub Cluster Setup**:
   - ArgoCD runs on the hub cluster.
   - All spoke clusters are added to the hub via `argocd cluster add`.
   
2. **GitOps Workflow**:
   - Kubernetes manifests are stored in Git (e.g., deployment.yaml, service.yaml).
   - ArgoCD syncs the manifests to the clusters, ensuring the desired state matches the actual state.

3. **State Management**:
   - Any manual changes to the clusters will be automatically reverted to the desired state defined in Git.

---

## Documentation

Detailed documentation and setup instructions are available on **[Medium](https://medium.com/@biekrogodbless/hub-and-spoke-architecture-project-with-argocd-an-elastic-kubernetes-project-by-godbless-biekro-a3512e1e5701)**:  
- [01 Prerequisites](./docs/01_prerequisites.md)  
- [02 Setting Up EKS Clusters](./docs/02_eks_setup.md)  
- [03 Configuring ArgoCD](./docs/03_argocd_setup.md)  

---

## Repository Structure

/projects/GitOps_ArgoCD_Multi_Cluster/
├── app_manifests/       # Kubernetes manifests for deployment
├── scripts/             # Setup and helper scripts
├── docs/                # Documentation
└── README.md            # Project overview

## Contributing
- Contributions are welcome! Feel free to fork the repository, submit issues, or open pull requests to improve the project.

## Author

- Created by Godbless Biekro
- Connect on [LinkedIn](https://www.linkedin.com/in/godbless-biekro-2289261ba/) and [Medium](https://medium.com/@biekrogodbless/) for more DevOps content.
