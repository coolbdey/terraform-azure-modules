output "id" {
  description = "The ID of the cosmos DB account."
  value       = azurerm_cosmosdb_account.cdba.id
}

output "endpoint" {
  description = "The endpoint used to connect to the CosmosDB account."
  value       = azurerm_cosmosdb_account.cdba.endpoint
}

output "read_endpoints" {
  description = "The read endpoint used to connect to the CosmosDB account."
  value       = azurerm_cosmosdb_account.cdba.read_endpoints
}

output "primary_key" {
  description = "The Primary key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.cdba.primary_key
}

output "primary_readonly_key" {
  description = "The Primary read-only key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.cdba.primary_readonly_key
}

output "secondary_key" {
  description = "The Secondary key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.cdba.secondary_key
}

output "secondary_readonly_key" {
  description = "The Secondary read-only key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.cdba.secondary_readonly_key
}

output "connection_strings" {
  description = "A list of connection strings available for this CosmosDB account"
  value       = azurerm_cosmosdb_account.cdba.connection_strings
}