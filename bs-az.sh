


ssh-keygen -t rsa -C "az-key" -f ~/.ssh/id_az  -P ""
export AZ_SSH_PUB_KEY_FILE=~/.ssh/id_az.pub



AZ_TFVARS=plus-az-infra-tf/az.auto.tfvars


# lif $GCP_TFVARS "project = " $PROJECT


source mc-az-networking.env

cat <<EOF > "$AZ_TFVARS"
az_ssh_pub_key_file = "$AZ_SSH_PUB_KEY_FILE"

EOF

awk -f env-to-tfvars.awk mc-az-networking.env >> "$AZ_TFVARS"