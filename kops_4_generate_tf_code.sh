#!/bin/bash
# kops_4_generate_tf_code.sh

# Ref: https://github.com/kubernetes/kops/blob/master/docs/getting_started/aws.md

AWS_PROFILE=kops
DOMAIN="learn-devops.online"
HOSTED_ZONE="kops.${DOMAIN}"
TEST_CLUSTER="test-cluster.${DOMAIN}"

kops create cluster \
  --cludd=aws \
  --name=${TEST_CLUSTER} \
  --state=s3://${HOSTED_ZONE}-tfstate-store \
  --authorization=RBAC \
  --zones=ap-southeast-1a \
  --master-count=1 \
  --master-size=t2.micro \
  --node-count=2 \
  --node-size=t2.micreo \
  --dns-zone=${HOSTED_ZONE} \
  --target=terraform
  --out=. \
  --ssh-public-key=~/.ssh/ec2-kp.pub

