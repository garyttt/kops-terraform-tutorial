KOPS (Ref: https://github.com/kubernetes/kops) has an option to generate terraform code (currently 0.11 format).

We can create AWS Kubernetes cluster via terraform code generated by kops. 

This tutorial provides scripts for:

1. Create kops IAM User (with just enough permissions to create the AWS infrastructure)
2. Configure DNS for self-owned DNS Sub-Domain but using hosted zone DNS servers in AWS to serve (Scenario 3 in documentation)
3. Create S3 state store required by terraform (with versioning and encryption enabled)
4. Generate the terraform code
5. Run the code after converting it to 0.12 format and fixing 0-0-0-0--0 references
