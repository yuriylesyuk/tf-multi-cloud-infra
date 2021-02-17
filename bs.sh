#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $BASEDIR/lib.sh

# just bootstrap, nothing noughty, actually


export PROJECT=$(gcloud projects list|grep qwiklabs-gcp|awk '{print $1}')
# override if required
REGION="europe-west1"
ZONE="europe-west1-b"


GCP_TFVARS=gcp.auto.tfvars
AWS_TFVARS=aws.auto.tfvars


# lif $GCP_TFVARS "project = " $PROJECT


source mc-gcp-networking.env

cat <<EOF > "$GCP_TFVARS"
gcp_project_id = "$PROJECT"
EOF

awk -f env-to-tfvars.awk mc-gcp-networking.env >> "$GCP_TFVARS"

source mc-aws-networking.env

cat <<EOF > "$AWS_TFVARS"
EOF

awk -f env-to-tfvars.awk mc-aws-networking.env >> "$AWS_TFVARS"

