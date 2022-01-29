output "id" {
  description = "The ID of the Application Insights component"
  value       = data.azurerm_application_insights.appi.id
}
output "instrumentation_key" {
  value = data.azurerm_application_insights.appi.instrumentation_key
}
output "connection_string" {
  value = data.azurerm_application_insights.appi.connection_string
}
output "app_id" {
  description = "The App ID associated with this Application Insights component."
  value       = data.azurerm_application_insights.appi.app_id
}
