#!/bin/bash

################################################################################
# Script Name:    launch_script.sh
# Description:    This script pulls the code from github and builds the artifact
# 		  using maven and then pass it to tomcat.
#
# Author:         Godbless Biekro
# Date Created:   2024-11-07
# Last Modified:  2024-11-11
# Version:        1.0.3
# Usage:          ./launch_script.sh
# Notes:          Requires sudo privileges.
#                 Tested on Ubuntu 20.04 LTS.
# Dependencies:   wget, apt, systemd
################################################################################

# Exit on error
set -e

# Enabling debugging for troubleshooting
set -x

repo_url=$1
repo_name=$(basename -s .git "$repo_url")

# Function Definitions
# ------------------------------------------------------------------------------
# Description: Pull java code form project repo
sudo apt-get update

pull_code() {
    echo "Checking if the repository $repo_name exists..."
    # Check if the repo directory already exists
    if [ -d "$repo_name" ]; then
        echo "Repository $repo_name already exists. Pulling the latest changes..."
        cd /tmp/"$repo_name" || { echo "Failed to navigate to $repo_name"; exit 1; }
        git pull "$repo_url" || { echo "Git pull failed"; exit 1; }
    else
        echo "Cloning the repository $repo_name..."
        cd /tmp/
        git clone "$repo_url" || { echo "Git clone failed"; exit 1; }
        cd /tmp/"$repo_name" || { echo "Failed to navigate to $repo_name"; exit 1; }
    fi
}


#Description: Build the java artifact

build_artifact() {
    echo "Building the Java artifact using Maven..."
    mvn clean package || { echo "Maven build failed"; exit 1; }
}

#Description: Send built artifact to the tomcat application

tomcat_manager() {

    sudo cp /tmp/"$repo_name"/target/*.war /opt/tomcat/webapps/
    # Restart and check the status of the Tomcat service
    sudo systemctl restart tomcat
}


#Description: Clean up
clean_up() {
    repo_url=$1
    repo_name=$(basename -s .git "$repo_url")

    #Back_up command to ensure artifact gets shipped to app server before cleaning
    # sudo mv /tmp/"$repo_name"/target/*.war /opt/tomcat/webapps/ROOT.war
    sudo rm -rf ~/"$repo_name"
}

# Check if we pass the args
if [ -z "$1" ]; then
    echo "Usage: $0 <repository_url>"
    exit 1
fi


pull_code "$1"
build_artifact
tomcat_manager
# clean_up "$1"