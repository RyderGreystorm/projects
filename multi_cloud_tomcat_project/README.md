# Multi-Cloud Project: Java Application Deployment on Apache Tomcat
<div align="right">
  <img src="https://github.com/RyderGreystorm/projects/blob/main/multi_cloud_tomcat_project/tomcar_IAAC.gif" alt="Coding Animation"/>
</div>
Welcome to this **multi-cloud project**, where a Java application is deployed to an **Apache Tomcat 9.0.65** web server using Infrastructure as Code (IaC). The project is designed to automate the entire process on both **AWS** and **Azure** with **zero manual UI interaction**. 

## Requirements
Before proceeding, ensure you have the following:
- **AWS CLI** (configured with appropriate credentials)
- **Azure CLI** (configured with appropriate credentials)
- **Active accounts on AWS and Azure**
- **Apache Tomcat version 9.0.65** (installation is automated)
- ** route53 Hosted Zone and Domain name

## Key Features
- Fully automated installation and configuration of **Apache Tomcat 9.0.65** via the `installation.sh` script, located in the `shell_scripts` directory.
- Automatic deployment of a Java application to Tomcat using IaC tools.
- Secure VPC configuration, leveraging dynamic IP whitelisting.
- Multi-cloud infrastructure management with Terraform.

## Project Overview
This project includes:
1. **`launch_scripts.sh`**: A shell script that automates the following tasks:
   - Cloning Java project code from a specified Git repository.
   - Building the application artifact using Maven.
   - Deploying the artifact to the Tomcat server as a separate process.
   
2. **`installation.sh`**: Handles the installation and configuration of Apache Tomcat on the provisioned virtual machines.

3. **Terraform Configurations**:
   - Infrastructure setup on AWS and Azure.
   - Security group configurations with IP whitelisting for enhanced security.
   - Deployment scripts for seamless integration between cloud environments.

## Important Notes
### AWS Configuration
- In `aws/vars.tf`, replace the `MY_IP` variable with your public IP address. This ensures that the AWS VPC security group is configured to allow secure access.
- The `aws/provider` block uses a profile named `"terradmin"` for the AWS IAM user. 
  - If you have a different profile configured, replace `"terradmin"` with your profile name.
  - If no profile is set up, remove the profile line and leave only the region.
  - Ensure you have a registred domain name else the Route53 will not work. Open **`aws/route53.tf`** and uncomment everything. Replace the domain name with your domain name. **NOTE. YOU CAN SIMPLY SKIP THIS BY LEAVING THE ROUTE53 CODE COMMENTED AND RUNNING EVERYTHING. THIS WILL RESULT IN YOU LAUNCHING THE INFRASTRUCTURE ON AWS AND AZURE WITHOUT YOU HAVING A UNIFIED LINK FOR THE TWO IP ADDRESSES** You will have to access the apps by visiting the ip public address of the instance from each provider

### Azure Configuration
- Ensure your Azure CLI is authenticated, as Terraform interacts with Azure APIs to provision the required resources.

### CLI Authentication
- **Authenticate AWS CLI**: Use `aws configure` to set up access keys, secret keys, and default region.
- **Authenticate Azure CLI**: Use `az login` to connect to your Azure account.

## Steps to Execute the Project
Follow these steps to provision the infrastructure and deploy the application:

1. **Initialize Terraform**
   ```bash
   terraform init

   terraform fmt

    terrafrom validate
 
    terraform apply --auto-approve

## Why This Project Matters
This project demonstrates the power of automation and IaC by reducing manual configuration steps and ensuring consistency across multi-cloud environments. It also highlights secure practices like IP whitelisting and modularized deployment.

## How to View the Project Once it is Launched
It will he running as a separate service in tomcat, so your url will look like **`http://53.23.25.211:8080/petclinic`**.
If you replaced the  github link with another repo url, then you must replace `petclinc` with the name of your artifact.


Contact
If you encounter issues or have questions, feel free to reach out. Collaboration and feedback are always welcome!
