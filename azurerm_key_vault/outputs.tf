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

output "key_ids" {
  description = "key vault key ids"
  value       = [for item in data.azurerm_key_vault_key.key: item.id]
}

output "secret_ids" {
  description = "key vault key secrets"
  value       = [for item in data.azurerm_key_vault_secret.secret: item.id]
}