output "id" {
  description = "The ID of the DDoS Protection Plan"
  value       = azurerm_network_ddos_protection_plan.ddospp.id
}
output "virtual_network_ids" {
  description = " - A list of Virtual Network ID's associated with the DDoS Protection Plan."
  value       = azurerm_network_ddos_protection_plan.ddospp.virtual_network_ids
}
