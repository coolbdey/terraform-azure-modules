output "id" {
  description = "The ID of the Linux Virtual Machine Scale Set."
  value       = azurerm_windows_virtual_machine_scale_set.vmss.id
}
output "principal_id" {
  description = "The Principal ID for the Service Principal associated with the Managed Service Identity of this Virtual Machine."
  value       = azurerm_windows_virtual_machine_scale_set.vmss.identity.0.principal_id
}

output "unique_id" {
  description = "The Unique ID for this Linux Virtual Machine Scale Set."
  value       = azurerm_windows_virtual_machine_scale_set.vmss.unique_id
}
