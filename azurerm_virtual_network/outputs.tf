output "id" {
  description = "The virtual NetworkConfiguration ID."
  value       = azurerm_virtual_network.vnet.id
}

output "address_space" {
  description = "The list of address spaces used by the virtual network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "guid" {
  description = " The GUID of the virtual network."
  value       = azurerm_virtual_network.vnet.guid
}

output "subnet_ids" {
  description = "Zero or more subnet ids."
  value       = [for item in azurerm_virtual_network.vnet.subnet : item.id]
}