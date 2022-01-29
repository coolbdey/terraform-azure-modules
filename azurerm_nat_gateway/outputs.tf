
output "natg_public_ip_prefix_ids" {
  description = "A list of existing Public IP Prefix resource IDs which the NAT Gateway is using."
  value       = data.azurerm_nat_gateway.natg.public_ip_prefix_ids
}
output "natg_resource_guid" {
  description = "The Resource GUID of the NAT Gateway."
  value       = data.azurerm_nat_gateway.natg.resource_guid
}
