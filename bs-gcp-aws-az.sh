#!/bin/bash
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$BASEDIR/bs-gcp-aws.sh"


ssh-keygen -t rsa -C "az-key" -f ~/.ssh/id_az  -P ""
export AZ_SSH_PUB_KEY_FILE=~/.ssh/id_az.pub


AZ_INFRA=$BASEDIR/infra-gcp-aws-az-tf
AZ_VARS=$BASEDIR/mc-az-networking.env
AZ_TFVARS=$AZ_INFRA/az.auto.tfvars


# lif $GCP_TFVARS "project = " $PROJECT


source $AZ_VARS

cat <<EOF > "$AZ_TFVARS"
az_ssh_pub_key_file = "$AZ_SSH_PUB_KEY_FILE"

EOF
awk -f $BASEDIR/tf-env-to-tfvars.awk "$AZ_VARS" >> "$AZ_TFVARS"
