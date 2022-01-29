output "id" {
  description = "value"
  value       = data.azurerm_data_protection_backup_vault.dpbv.id
}

output "principal_id" {
  description = "value"
  value       = azurerm_data_protection_backup_vault.dpbv.identity.0.principal_id
}
