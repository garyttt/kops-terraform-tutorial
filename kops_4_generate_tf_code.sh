#!/bin/bash
# kops_4_generate_tf_code.sh

# Ref: https://github.com/kubernetes/kops/blob/master/docs/getting_started/aws.md
# This script generates kubernetes.tf and many suppoting files in data/ folder

export AWS_PROFILE=kops
DOMAIN="learn-devops.online"
HOSTED_ZONE="kops.${DOMAIN}"

kops create cluster \
  --cloud=aws \
  --name=${HOSTED_ZONE} \
  --state=s3://${HOSTED_ZONE}-tfstate-store \
  --authorization=RBAC \
  --zones=ap-southeast-1a \
  --master-count=1 \
  --master-size=t2.micro \
  --node-count=2 \
  --node-size=t2.micro \
  --dns-zone=${HOSTED_ZONE} \
  --target=terraform \
  --out=. \
  --ssh-public-key=~/.ssh/ec2-kp.pub

cp -p kubernetes.tf kubernetes.tf.orig
