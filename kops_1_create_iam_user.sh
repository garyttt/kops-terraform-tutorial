#!/bin/bash
# kops_1_create_iam_users.sh

# Ref: https://github.com/kubernetes/kops/blob/master/docs/getting_started/aws.md
# Typically an one-time script unless user and group are manuakly deleted

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
aws iam create-access-key --user-name $AWS_USR | tee ~/.aws/tmp$$.log

echo "Please copy and paste the ACCESS_KEY_ID and SECRET_ACCESS_KEY as shown above to your AWS PROFILE for ${AWS_USR}"
echo "Example: paste the following lines to ~/.aws/credentials"
echo 
cat <<EOF >&1
[kops]
aws_access_key_id = ACCESS_KEY_ID 
aws_secret_access_key = SECRET_ACCESS_KEY  

EOF

echo "Automating the above: creating ${AWS_USR} AWS profile..."
AKI=`cat ~/.aws/tmp$$.log | jq '.AccessKey.AccessKeyId' | tr -d \"`
SAK=`cat ~/.aws/tmp$$.log | jq '.AccessKey.SecretAccessKey' | tr -d \"`
aws configure --profile=kops set aws_access_key_id $AKI
aws configure --profile=kops set aws_secret_access_key $SAK
aws configure --profile=kops set region ap-southeast-1
aws configure --profile=kops set output json

# Make sure you clean-up log containing sensitive credentials, and protect it
rm -f ~/.aws/tmp$$.log 
chmod 600 ~/.aws/credentials
