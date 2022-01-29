output "maximum_number_of_workers" {
  description = "The maximum number of workers supported with the App Service Plan's sku."
  value       = data.azurerm_app_service_plan.asp.maximum_number_of_workers
}

output "id" {
  description = "The ID of the App Service Plan component"
  value       = data.azurerm_app_service_plan.asp.id
}

output "kind" {
  description = "The Operating system type (Windows or Linux)"
  value       = var.kind
}

output "tier" {
  description = "The tier of App Service Plan, Free, Shared, Standard"
  value       = var.tier
}
