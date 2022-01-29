output "id" {
  value = data.azurerm_app_configuration.appc.id
}

output "endpoint" {
  value = data.azurerm_app_configuration.appc.endpoint
}

output "primary_read_key" {
  description = "A primary_read_key block as defined below containing the primary read access key."
  value       = data.azurerm_app_configuration.appc.primary_read_key
}

output "primary_write_key" {
  description = "A primary_write_key block as defined below containing the primary write access key."
  value       = data.azurerm_app_configuration.appc.primary_write_key
}
