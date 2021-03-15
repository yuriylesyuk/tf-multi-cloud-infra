
# Check we are logged in


set -e

# check we are logged in
echo "Check if logged in gcloud: "
gcloud compute instances list

echo "Check if logged in aws: "
aws sts get-caller-identity


./bs-gcp-aws.sh

cd infra-gcp-aws-tf

terraform init
terraform apply --auto-approve

