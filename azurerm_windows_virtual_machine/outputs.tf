output "id" {
  description = "The ID of the Windows Virtual Machine."
  value       = azurerm_windows_virtual_machine.wvm.id
}
output "virtual_machine_id" {
  description = "A 128-bit identifier which uniquely identifies this Virtual Machine."
  value       = azurerm_windows_virtual_machine.wvm.virtual_machine_id
}
output "principal_id" {
  description = "The Principal ID for the Service Principal associated with the Managed Service Identity of this Virtual Machine."
  value       = azurerm_windows_virtual_machine.wvm.identity.0.principal_id
}

output "private_ip_address" {
  description = "The Primary Private IP Address assigned to this Virtual Machine."
  value       = azurerm_windows_virtual_machine.wvm.private_ip_address
}

output "private_ip_addresses" {
  description = " A list of Private IP Addresses assigned to this Virtual Machine."
  value       = azurerm_windows_virtual_machine.wvm.private_ip_addresses
}

output "public_ip_address" {
  description = "The Primary Public IP Address assigned to this Virtual Machine."
  value       = azurerm_windows_virtual_machine.wvm.public_ip_address
}

output "public_ip_addresses" {
  description = " A list of Public IP Addresses assigned to this Virtual Machine."
  value       = azurerm_windows_virtual_machine.wvm.public_ip_addresses
}