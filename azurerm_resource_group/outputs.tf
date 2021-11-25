output "name" {
  description = "resource group name"
  value       = data.azurerm_resource_group.rg.name
}

output "id" {
  description = "resource group ids"
  value       = data.azurerm_resource_group.rg.id
}

output "location" {
  description = "resource group locations"
  value       = data.azurerm_resource_group.rg.location
}

output "tags" {
  description = "resource group tags"
  value       = data.azurerm_resource_group.rg.tags
}
