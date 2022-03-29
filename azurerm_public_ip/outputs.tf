output "id" {
  description = "The ID of this Public IP."
  value       = azurerm_public_ip.pipa.id
}

output "ip_address" {
  # Note: Dynamic Public IP Addresses aren't allocated until they're attached to a device (e.g. a Virtual Machine/Load Balancer). Instead you can obtain the IP Address once the Public IP has been assigned via the azurerm_public_ip Data Source.
  description = "The IP address value that was allocated."
  value       = azurerm_public_ip.pipa.ip_address
}

output "domain_name_label" {
  description = ""
  value = azurerm_public_ip.pipa.domain_name_label
}

# Prefix
output "ip_prefix" {
  description = "Public IP Prefix if exist"
  value       = [for item in data.azurerm_public_ip_prefix.pipp : item.ip_prefix]
}
