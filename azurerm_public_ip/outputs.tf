output "id" {
  description = "value"
  value       = data.azurerm_public_ip.pipa.id
}

output "ip_address" {
  description = "value"
  value       = data.azurerm_public_ip.pipa.ip_address
}

output "domain_name_label" {
  value = data.azurerm_public_ip.pipa.domain_name_label
}

# Prefix
output "ip_prefix" {
  description = "Public IP Prefix if exist"
  value       = [for item in data.azurerm_public_ip_prefix.pipp : item.ip_prefix]
}
