#!/bin/bash
################################################################################
# Script Name:    bastion_user_data.sh
# Description:    Installs essential tools and services: Maven, Jenkins, Docker,
#                 Terraform, AWS CLI, Trivy, and SonarQube.
#
# Author:         Godbless Biekro
# Date Created:   2024-12-14
# Last Modified:  2024-12-14
# Version:        1.1.0
# Notes:          Requires sudo privileges. Tested on Ubuntu 22.04 LTS.
################################################################################

set -e  # Exit immediately if a command exits with a non-zero status.

jdk_installation() {
    echo "Installing JDK 17..."
    sudo apt update && sudo apt install -y openjdk-17-jdk
    java -version && echo "JDK installed successfully."
}

jenkins_installation() {
    echo "Installing Jenkins..."
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update && sudo apt-get install -y jenkins
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    echo "Jenkins installed and started successfully."
}

docker_installation() {
    echo "Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker $USER
    echo "Docker installed successfully."
}

terraform_installation() {
    echo "Installing Terraform..."
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt-get update && sudo apt-get install -y terraform
    terraform -version && echo "Terraform installed successfully."
}

aws_cli_installation() {
    echo "Installing AWS CLI..."
    sudo apt-get update && sudo apt-get install -y unzip
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
    aws --version && echo "AWS CLI installed successfully."
}

trivy_installation() {
    echo "Installing Trivy..."
    sudo apt-get install -y wget gnupg
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee /etc/apt/sources.list.d/trivy.list
    sudo apt-get update && sudo apt-get install -y trivy
    trivy -v && echo "Trivy installed successfully."
}

sonarqube() {
    echo "Installing SonarQube..."
    docker run -d --name sonarqube -p 9000:9000 -v sonarqube_data:/opt/sonarqube/data -v sonarqube_logs:/opt/sonarqube/logs sonarqube:lts-community
    echo "SonarQube container started successfully."
}

# Execute Functions
jdk_installation
jenkins_installation
docker_installation
terraform_installation
aws_cli_installation
trivy_installation
sonarqube

echo "All installations completed successfully."
