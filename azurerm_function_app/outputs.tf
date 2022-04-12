output "id" {
  description = "The ID of the Function App"
  value       = azurerm_function_app.fa.id
}
output "custom_domain_verification_id" {
  description = "An identifier used by App Service to perform domain ownership verification via DNS TXT record."
  value       = azurerm_function_app.fa.custom_domain_verification_id
}
output "outbound_ip_addresses" {
  description = "A list of outbound IP addresses"
  value       = split(azurerm_function_app.fa.outbound_ip_addresses, ",")
}
output "possible_outbound_ip_addresses" {
  description = "A list of outbound IP addresses not all of which are necessarily in use. Superset of outbound_ip_addresses."
  value       = split(azurerm_function_app.fa.possible_outbound_ip_addresses, ",")
}
output "principal_id" {
  description = "The Principal ID for the Service Principal associated with the Managed Service Identity of this App Service."
  value       = azurerm_function_app.fa.identity.0.principal_id
}
output "kind" {
  description = "The Function App kind - such as functionapp,linux,container"
  value       = azurerm_function_app.fa.kind
}
output "default_hostname" {
  description = "The default hostname associated with the Function App - such as mysite.azurewebsites.net"
  value       = azurerm_function_app.fa.default_hostname
}
