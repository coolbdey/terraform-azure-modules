output "id" {
  description = "The ID of the Static Web App"
  value       = azurerm_static_site.ss.id
}
output "api_key" {
  description = "The API key of this Static Web App, which is used for later interacting with this Static Web App from other clients, e.g. Github Action."
  value       = azurerm_static_site.ss.api_key
}
output "default_host_name" {
  description = "The default host name of the Static Web App."
  value       = azurerm_static_site.ss.default_host_name
}
