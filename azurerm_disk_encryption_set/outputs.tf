output "id" {
  description = "The ID of the Disk Encryption Set."
  value       = azurerm_disk_encryption_set.des.id
}
output "principal_id" {
  description = "The (Client) ID of the Service Principal."
  value       = azurerm_disk_encryption_set.des.identity.0.principal_id
}
output "tenant_id" {
  description = "The ID of the Tenant the Service Principal is assigned in."
  value       = azurerm_disk_encryption_set.des.identity.0.principal_id
}