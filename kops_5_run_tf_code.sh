#!/bin/bash
# kops_5_run_tf_code.sh

sed -i 's/0-0-0-0--0/kops/g' kubernetes.tf
terraform init
#terraform validate
#terraform 0.12upgrade -force
#terraform validate
#terraform plan -out=kubernetes.tfplan
#terraform apply "kubernetes.tfplan"
