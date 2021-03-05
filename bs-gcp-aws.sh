#!/bin/bash
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# just bootstrap, nothing noughty, actually


export PROJECT=$(gcloud projects list|grep qwiklabs-gcp|awk '{print $1}')
export GCP_OS_USERNAME=$(gcloud config get-value account | awk -F@ '{print $1}' )

#
ssh-keygen -t rsa -C "gcp-key" -f ~/.ssh/id_gcp  -P ""
export GCP_SSH_PUB_KEY_FILE=~/.ssh/id_gcp.pub

ssh-keygen -t rsa -C "aws-key" -f ~/.ssh/id_aws -P ""
export AWS_KEY_NAME=aws-key
export AWS_SSH_PUB_KEY_FILE=~/.ssh/id_aws.pub

# override if required
REGION="europe-west1"
ZONE="europe-west1-b"

GCP_AWS_INFRA=$BASEDIR/infra-gcp-aws-tf

GCP_TFVARS=$GCP_AWS_INFRA/gcp.auto.tfvars
AWS_TFVARS=$GCP_AWS_INFRA/aws.auto.tfvars


GCP_VARS=$BASEDIR/mc-gcp-networking.env

source $GCP_VARS

cat <<EOF > "$GCP_TFVARS"
gcp_project_id = "$PROJECT"

gcp_os_username = "$GCP_OS_USERNAME"
gcp_ssh_pub_key_file = "$GCP_SSH_PUB_KEY_FILE"

EOF
awk -f $BASEDIR/tf-env-to-tfvars.awk $GCP_VARS >> "$GCP_TFVARS"


AWS_VARS=$BASEDIR/mc-aws-networking.env
source $AWS_VARS



cat <<EOF > "$AWS_TFVARS"
aws_key_name = "$AWS_KEY_NAME"
aws_ssh_pub_key_file = "$AWS_SSH_PUB_KEY_FILE"
EOF

awk -f $BASEDIR/tf-env-to-tfvars.awk $AWS_VARS >> "$AWS_TFVARS"
