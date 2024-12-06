
I built this project completely on a Windows computer using chocolatey to install all my tools. You can also install chocolatey by simply visiting the official documentation at: https://chocolatey.org/install


AWS CLI: You can install AWS CLI using chocolatey, simply run 
`choco install awscli -y`
If you are on mac or other OS, please visit this page for guide on how to install aws cli: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
After installation, see how to configure AWS CLI here, please take note of the IAM name as this is your profile name which you will use to interact with your aws account anytime you run a program from the command line: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config


kubectl:
Using chocolatey you can run:
`choco install choco install kubernetes-cli -y`
For other distributions, see https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html


eksctl:
Using chocolatey you can run:
'choco install eksctl -y'
For other OS, see https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html


ArgoCD CLI
Using chocolatey, you can run:
`choco install choco install argocd-cli -y`
For other OS, see https://argo-cd.readthedocs.io/en/stable/cli_installation/#installation
