#!/bin/bash
# kops_1_create_iam_users.sh

# Ref: https://github.com/kubernetes/kops/blob/master/docs/getting_started/aws.md

export AWS_PROFILE=garyttt8
AWS_USR=kops
AWS_GRP=kops

aws iam create-group --group-name $AWS_GRP
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name $AWS_GRP
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name $AWS_GRP
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name $AWS_GRP
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name $AWS_GRP
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name $AWS_GRP
aws iam create-user --user-name $AWS_USR
aws iam get-user --user-name $AWS_USR
aws iam add-user-to-group --user-name $AWS_USR --group-name $AWS_GRP
aws iam create-access-key --user-name $AWS_USR

echo "Please copy and paste the ACCESS_KEY_ID and SECRET_ACCESS_KEY to your AWS PROFILE"
echo "Example: paste the following lines to ~/.aws/credentials"
echo 
cat <<EOF >&1
[kops]
aws_access_key_id = ACCESS_KEY_ID 
aws_secret_access_key = SECRET_ACCESS_KEY  

EOF
