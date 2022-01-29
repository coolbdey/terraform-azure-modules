data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_virtual_network" "vnet" {
  depends_on = [azurerm_virtual_network.vnet]

  name                = var.name
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name
}

data "azurerm_network_ddos_protection_plan" "dpp" {
  depends_on = [azurerm_network_ddos_protection_plan.dpp]

  name                = azurerm_network_ddos_protection_plan.dpp.name
  resource_group_name = azurerm_network_ddos_protection_plan.dpp.resource_group_name
}

data "azurerm_network_watcher" "nw" {
  depends_on = [azurerm_network_watcher.nw]

  name                = azurerm_network_watcher.nw.name
  resource_group_name = azurerm_network_watcher.nw.resource_group_name
}
