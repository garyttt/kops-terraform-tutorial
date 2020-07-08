#!/bin/bash
# kops_6_tf_destroy.sh

terraform destroy | tee terraform_destroy.log
