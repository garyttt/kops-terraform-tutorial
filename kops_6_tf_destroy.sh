#!/bin/bash
# kops_6_tf_destroy.sh

export AWS_PROFILE=garyttt8
terraform destroy | tee terraform_destroy.log
