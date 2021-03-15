
# Check we are logged in


set -e

# check we are logged in
echo "Check if logged in gcloud: "
gcloud compute instances list

echo "Check if logged in aws: "
aws sts get-caller-identity

echo "Check if logged in az: "
az account show


echo "!!!!!!!!!"
exit

# Check required environment variables


./bs-gcp-aws-az.sh

cd infra-gcp-aws-az-tf

terraform init
terraform apply --auto-approve

