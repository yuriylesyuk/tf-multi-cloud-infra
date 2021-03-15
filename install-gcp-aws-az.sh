
# Check we are logged in




az status




# Check required environment variables


./bs-gcp-aws-az.sh

cd infra-gcp-aws-az-tf

terraform init
terraform apply --auto-approve

