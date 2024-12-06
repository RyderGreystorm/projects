#!/bin/bash

# Prompt the user for a number of spoke clusters to create
echo -n "How many spoke clusters are you creating: "
read number

echo -n "What name do you want to call your hub cluster: "
read hub_name

echo -n "In which region are you creating this cluster? [eg: us-east-1]: "
read region

echo -n "What is the name of the AWS IAM user creating this resource [enter profile name]: "
read profile

# Validate if input for number of cluster is a positive integer
if ! [[ "$number" =~ ^[0-9]+$ ]]; then
    echo "Please enter a valid positive number."
    exit 1
fi

# Confirm the details before proceeding
echo
echo "You are about to create the following:"
echo "  - $number spoke clusters"
echo "  - Hub cluster: $hub_name"
echo "  - AWS region: $region"
echo "  - AWS profile: $profile"
echo
read -p "Do you want to proceed? (yes/no): " confirm
if [[ "$confirm" != "yes" ]]; then
    echo "Operation canceled."
    exit 0
fi

# Create the hub cluster
echo "Creating hub cluster: $hub_name"
if eksctl create cluster --name "$hub_name" --region "$region" --profile "$profile"; then
    echo "Hub cluster $hub_name created successfully."
else
    echo "Failed to create hub cluster $hub_name."
    exit 1
fi

# Create the spoke clusters
for ((i = 1; i <= number; i++)); do
    cluster_name="spoke$i"
    echo "Creating spoke cluster: $cluster_name"
    if eksctl create cluster --name "$cluster_name" --region "$region" --profile "$profile"; then
        echo "Spoke cluster $cluster_name created successfully."
    else
        echo "Failed to create spoke cluster $cluster_name. Exiting."
        exit 1
    fi
done

echo "All clusters created successfully."

