output "id" {
  value = data.azurerm_virtual_network.vnet.id
}
output "ddos_protection_plan_id" {
  value = data.azurerm_network_ddos_protection_plan.dpp
}

output "network_watcher_id" {
  value = data.azurerm_network_watcher.nw.id
}
