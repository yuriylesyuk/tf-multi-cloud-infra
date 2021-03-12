#!/bin/bash
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$BASEDIR/bs-gcp-aws.sh


ssh-keygen -t rsa -C "az-key" -f ~/.ssh/id_az  -P ""
export AZ_SSH_PUB_KEY_FILE=~/.ssh/id_az.pub



# source gcp and aws vars to have if they are used in az vars
GCP_VARS=$BASEDIR/mc-gcp-networking.env
source $GCP_VARS
AWS_VARS=$BASEDIR/mc-aws-networking.env
source $AWS_VARS


AZ_INFRA=$BASEDIR/infra-gcp-aws-az-tf
AZ_VARS=$BASEDIR/mc-az-networking.env
AZ_TFVARS=$AZ_INFRA/az.auto.tfvars


# lif $GCP_TFVARS "project = " $PROJECT


source $AZ_VARS

cat <<EOF > "$AZ_TFVARS"
az_ssh_pub_key_file = "$AZ_SSH_PUB_KEY_FILE"

EOF
awk -f $BASEDIR/tf-env-to-tfvars.awk "$AZ_VARS" >> "$AZ_TFVARS"



# tf: module 'import'
GCP_AWS_INFRA=$BASEDIR/infra-gcp-aws-tf

cp $GCP_AWS_INFRA/aws.auto.tfvars $AZ_INFRA
cp $GCP_AWS_INFRA/gcp.auto.tfvars $AZ_INFRA

awk -f $BASEDIR/tfi-module-include.awk $AZ_INFRA/az-modules.tfi > $AZ_INFRA/az-modules.tfi.tf

