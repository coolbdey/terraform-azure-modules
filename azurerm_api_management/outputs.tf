output "id" {
  description = "The ID of the API Management Service."
  value       = data.azurerm_api_management.apim.id
}

output "gateway_url" {
  description = "The URL of the Gateway for the API Management Service."
  value       = data.azurerm_api_management.apim.gateway_url
}

output "management_api_url" {
  description = "The URL for the Management API associated with this API Management service."
  value       = data.azurerm_api_management.apim.management_api_url
}

output "portal_url" {
  description = "The URL for the Publisher Portal associated with this API Management service."
  value       = data.azurerm_api_management.apim.portal_url
}

output "public_ip_addresses" {
  description = "The Public IP addresses of the API Management Service."
  value       = data.azurerm_api_management.apim.public_ip_addresses
}

output "developer_portal_url" {
  description = "The URL for the Developer Portal associated with this API Management service."
  value       = data.azurerm_api_management.apim.developer_portal_url
}

output "identity_principal_id" {
  description = "he Principal ID associated with this Managed Service Identity."
  value       = azurerm_api_management.apim.identity.0.principal_id
}

/*
output "api_outputs" {
  description = "The IDs, state, and version outputs of the APIs created"
  value = {
    id             = data.azurerm_api_management_api.api.id
    is_current     = data.azurerm_api_management_api.api.is_current
    is_online      = data.azurerm_api_management_api.api.is_online
    version        = data.azurerm_api_management_api.api.version
    version_set_id = data.azurerm_api_management_api.api.version_set_id
  }
}
*/

/*

output "product_ids" {
  description = "The ID of the Product created"
  value       = azurerm_api_management_product.*.product.id
}
*/
### USers

output "users_id" {
  value = azurerm_api_management_user.user.*.id
}
