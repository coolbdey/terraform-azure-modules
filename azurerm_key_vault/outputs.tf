output "name" {
  description = "key vault name"
  value       = data.azurerm_key_vault.kv.name
}

output "id" {
  description = "key vault id"
  value       = data.azurerm_key_vault.kv.id
}

output "url" {
  description = "key vault url"
  value       = data.azurerm_key_vault.kv.vault_uri
}