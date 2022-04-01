output "id" {
  description = "The ID of the Service Plan"
  value       = azurerm_service_plan.sp.id
}

output "kind" {
  description = "A string representing the Kind of Service Plan."
  value       = azurerm_service_plan.sp.kind
}

output "location" {
  description = "The Azure Region where the Service Plan exists."
  value       = azurerm_service_plan.sp.location
}

output "os_type" {
  description = "The O/S type for the App Services hosted in this plan."
  value       = azurerm_service_plan.sp.os_type
}

output "reserved" {
  description = "Whether this is a reserved Service Plan Type. true if os_type is Linux, otherwise false."
  value       = azurerm_service_plan.sp.reserved
}

output "is_consumtion_plan" {
  value = local.is_consumtion_plan
}

output "is_premium_plan" {
  value = local.is_elastic
}
