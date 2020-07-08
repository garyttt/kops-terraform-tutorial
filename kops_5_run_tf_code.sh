#!/bin/bash
# kops_5_run_tf_code.sh

# Un-comment to reset for next test run
cp -p kubernetes.tf.orig kubernetes.tf
rm -rf .terraform >/dev/null 2>&1
rm -f version*.tf >/dev/null 2>&1

sed -i 's/0-0-0-0--0/kops/g' kubernetes.tf
terraform init
terraform validate
echo yes | terraform 0.12upgrade -force
terraform validate
terraform plan -out=kubernetes.tfplan
terraform apply "kubernetes.tfplan"
