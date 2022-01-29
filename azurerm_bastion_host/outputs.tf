output "id" {
  description = "The ID of the Bastion Host."
  value       = azurerm_bastion_host.bas.id
}
output "dns_name" {
  description = "The FQDN for the Bastion Host."
  value       = azurerm_bastion_host.bas.dns_name
}
