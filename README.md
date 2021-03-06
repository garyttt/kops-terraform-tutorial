KOPS (Ref: https://github.com/kubernetes/kops) has an option to generate terraform code (currently 0.11 format).

Original idea: https://samratpriyadarshi.com/kubernetes-tutorial-series-kubernetes-architecture-installation/ (Dec 2018)

Assumptions: you have Docker Desktop for Windows 2.3.4.0 (with WSL2 ubuntu 20.04 Linux backend), and the following client tools installed in ubuntu:
kops 1.17, terraform 0.12, awscli v2.0 and kubectl 1.18.X, jq 1.6.
You have a free-tier AWS account, you have prepared a SSH public key, and you have purchased or owned a DNS domain.
We can create AWS Kubernetes cluster via terraform code generated by kops. 

This tutorial provides scripts for:

1. Create kops IAM User (with just enough permissions to create the AWS infrastructure), once done use this account for script 4 to 5
2. Configure DNS for self-owned DNS Sub-Domain but using hosted zone DNS servers in AWS to serve (Scenario 3 in documentation)
3. Create S3 state store required by terraform (with versioning and encryption enabled)
4. Generate the terraform code
5. Run the code after converting it to 0.12 format and fixing 0-0-0-0--0 references

6. Feel free to explore, for example terminate one of the worker nodes to see what will happen. After playing with it, DON'T FORGET to 'terraform destroy' to avoid AWS resources usage charges!!! Note that 'terraform destroy' only removes those resources it has created. kops user/group, hosted zone and s3 bucket will have to be manually deleted.
