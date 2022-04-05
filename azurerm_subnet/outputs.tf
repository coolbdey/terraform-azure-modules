output "id" {
  value = [for item in azurerm_subnet.snet : item.id]
}
output "address_prefixess" {
  value = [for item in azurerm_subnet.snet : item.address_prefixes]
}
output "network_security_group_id" {
  value = [for item in azurerm_subnet.snet : item.network_security_group_id]
}
