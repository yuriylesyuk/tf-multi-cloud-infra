output "gcp_jumpbox_ip" {
  value = module.gcp_and_aws_infra.gcp_jumpbox_ip
}

output "aws_jumpbox_ip" {
  value = module.gcp_and_aws_infra.aws_jumpbox_ip
}

output "az_jumpbox_ip" {
 # value = azurerm_.ip_address
 value = data.azurerm_public_ip.vm_az_pip_ref.ip_address

}