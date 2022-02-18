data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_virtual_network" "vnet" {
  depends_on = [azurerm_virtual_network.vnet]

  name                = var.name
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name
}
