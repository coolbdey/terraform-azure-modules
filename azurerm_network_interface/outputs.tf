# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_interface

output "id" {
  description = "The ID of the Network Interface."
  value       = azurerm_network_interface.nic.id
}

output "mac_address" {
  description = "The MAC address used by the specified Network Interface."
  value       = azurerm_network_interface.nic.mac_address
}

output "private_ip_address" {
  description = "The primary private ip address associated to the specified Network Interface."
  value       = azurerm_network_interface.nic.private_ip_address
}

output "private_ip_addresses" {
  description = "The private IP addresses of the network interface."
  value       = azurerm_network_interface.nic.private_ip_addresses
}

output "virtual_machine_id" {
  description = "The ID of the virtual machine that the specified Network Interface is attached to."
  value       = azurerm_network_interface.nic.virtual_machine_id
}

output "internal_domain_name_suffix" {
  description = "Even if internal_dns_name_label is not specified, a DNS entry is created for the primary NIC of the VM. This DNS name can be constructed by concatenating the VM name with the value of internal_domain_name_suffix."
  value = azurerm_network_interface.nic.internal_domain_name_suffix
}

output "applied_dns_servers" {
  description = " If the Virtual Machine using this Network Interface is part of an Availability Set, then this list will have the union of all DNS servers from all Network Interfaces that are part of the Availability Set."
  value       = azurerm_network_interface.nic.applied_dns_servers
}

