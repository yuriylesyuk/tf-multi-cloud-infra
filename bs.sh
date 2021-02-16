#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $BASEDIR/lib.sh

# just bootstrap, nothing noughty, actually


export PROJECT=$(gcloud projects list|grep qwiklabs-gcp|awk '{print $1}')
# override if required
REGION="europe-west1"
ZONE="europe-west1-b"


GCP_VARS=gcp.auto.tfvars

# lif $GCP_VARS "project = " $PROJECT


cat <<EOF > "$GCP_VARS"
gcp_project_id = "$PROJECT"
EOF


source mc-networking.env

awk -f env-to-tfvars.awk mc-networking.env >> "$GCP_VARS"

