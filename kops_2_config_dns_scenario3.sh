#!/bin/bash
# kops_2_config_dns_screnario3.sh

# Ref: https://github.com/kubernetes/kops/blob/master/docs/getting_started/aws.md
# Scenario 3: Subdomain for clusters in route53, leaving the domain at another registrar

export AWS_PROFILE=kops
DOMAIN="learn-devops.online"
SUBDOMAIN="kops.${DOMAIN}"
SUBDOMAINDOT="kops.${DOMAIN}."

# Ref: https://stackoverflow.com/questions/40027395/passing-bash-variable-to-jq-select
# This link contains a fix on how to pass shell variable into jq query select statement

echo "Note your hosted zone ID for Subdomain $SUBDOMAIN existence"
HZC=$(aws route53 list-hosted-zones | jq -r --arg SUBDOMAINDOT "$SUBDOMAINDOT" '.HostedZones[] | select(.Name==$SUBDOMAINDOT) | .Id' | tee /dev/stderr)

if [ -z "$HZC" ]; then
  echo "Create the subdomain as Subdomain does not exist and show the NameServers (NS) Records"
  ID=$(uuidgen) && aws route53 create-hosted-zone --name $SUBDOMAIN --caller-reference $ID | jq .DelegationSet.NameServers
else
  echo "Note your nameservers for the subdomain as it exists and show the NameServers (NS) Records"
  aws route53 get-hosted-zone --id $HZC | jq .DelegationSet.NameServers
fi

echo "You will now go to your registrar's page and log in. You will need to create a new SUBDOMAIN, and use the 4 NS records received from the above command for the new SUBDOMAIN. This MUST be done in order to use your cluster. Do NOT change your top level NS record, or you might take your site offline."

echo "Testing your DNS Setup once you have completed the SUBDOMAIN $SUBDOMAIN creation and added the NS records AT YOUR DNS PROVIDER SITE, otherwise expect the dig command to fail"
dig ns $SUBDOMAIN

