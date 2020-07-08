#!/bin/bash
# kops_3_create_s3_tfstate_store.sh

# Ref: https://github.com/kubernetes/kops/blob/master/docs/getting_started/aws.md

export AWS_PROFILE=garyttt8
DOMAIN="learn-devops.online"
SUBDOMAIN="kops.${DOMAIN}"
REGION="ap-southeast-1"
BUCKET="${SUBDOMAIN}-tfstate-store"

aws s3api create-bucket \
    --region $REGION \
    --bucket $BUCKET \
    --create-bucket-configuration LocationConstraint=$REGION

aws s3api put-bucket-versioning \
    --bucket $BUCKET \
    --versioning-configuration Status=Enabled

aws s3api put-bucket-encryption \
    --bucket $BUCKET \
    --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
