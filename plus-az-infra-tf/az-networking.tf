
module "gcp_and_aws_infra" {
  source = "../gcp-aws-vpc-infra-tf"
}


resource "azurerm_virtual_network" "az_vnet" {
  name                = var.az_vnet
  location            = var.az_region
  resource_group_name = var.resource_group
  address_space       = [ var.az_vnet_cidr ]

  subnet {
    name           = var.az_vnet_subnet
    address_prefix = var.az_vnet_subnet_cidr
  }
}

