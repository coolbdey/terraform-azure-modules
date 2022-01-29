output "id" {
  description = "The Log Analytics Workspace ID."
  value       = data.azurerm_log_analytics_workspace.law.id
}

output "primary_shared_key" {
  description = "The Primary shared key for the Log Analytics Workspace."
  value       = data.azurerm_log_analytics_workspace.law.primary_shared_key
}

output "secondary_shared_key" {
  description = "The Secondary shared key for the Log Analytics Workspace."
  value       = data.azurerm_log_analytics_workspace.law.secondary_shared_key
}

output "workspace_id" {
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace"
  value       = data.azurerm_log_analytics_workspace.law.workspace_id
}