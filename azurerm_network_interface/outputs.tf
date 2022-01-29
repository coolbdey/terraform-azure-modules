# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_interface

output "id" {
  description = "The ID of the Network Interface."
  value       = data.azurerm_network_interface.nic.id
}

output "mac_address" {
  description = "The MAC address used by the specified Network Interface."
  value       = data.azurerm_network_interface.nic.mac_address
}

output "private_ip_address" {
  description = "The primary private ip address associated to the specified Network Interface."
  value       = data.azurerm_network_interface.nic.private_ip_address
}

output "virtual_machine_id" {
  description = "he ID of the virtual machine that the specified Network Interface is attached to."
  value       = data.azurerm_network_interface.nic.virtual_machine_id
}
