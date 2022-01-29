output "id" {
  value = azurerm_virtual_machine.vm.id
}
output "principal_id" {
  description = "The Principal ID for the Service Principal associated with the Managed Service Identity of this Virtual Machine."
  value       = azurerm_virtual_machine.vm.identity.0.principal_id
}
