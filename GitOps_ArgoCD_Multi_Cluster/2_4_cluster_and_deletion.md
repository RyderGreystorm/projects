Instead of running the creating script, you can mannually run the commands below. You can add the `--profile` flag if you have multiple aws cli profiles configured. If you have only one account, then ignore the --profile flag.

EKS Clusters Creation
eksctl create cluster --name hub-cluster --region us-east-1

eksctl create cluster --name spoke-cluster-1 --region us-east-1

eksctl create cluster --name spoke-cluster-2 --region us-east-1


EKS Cluster Deletion
eksctl delete cluster --name hub-cluster --region us-east-1

eksctl delete cluster --name spoke-cluster-1 --region us-east-1

eksctl delete cluster --name spoke-cluster-2 --region us-east-1

