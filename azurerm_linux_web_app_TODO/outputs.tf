output "id" {
  description = "The ID of the Web App"
  value       = azurerm_app_service.wa.id
}
output "custom_domain_verification_id" {
  description = "An identifier used by App Service to perform domain ownership verification via DNS TXT record."
  value       = azurerm_app_service.wa.custom_domain_verification_id
}
output "outbound_ip_addresses" {
  description = "A list of outbound IP addresses"
  value       = split(azurerm_app_service.wa.outbound_ip_addresses, ",")
}
output "possible_outbound_ip_addresses" {
  description = "A list of outbound IP addresses - such as 52.23.25.3,52.143.43.12,52.143.43.17 - not all of which are necessarily in use. Superset of outbound_ip_addresses."
  value       = split(azurerm_app_service.wa.possible_outbound_ip_addresses, ",")
}
output "identity" {
  description = " An identity block as defined below, which contains the Managed Service Identity information for this App Service."
  value       = azurerm_app_service.wa.identity
}
