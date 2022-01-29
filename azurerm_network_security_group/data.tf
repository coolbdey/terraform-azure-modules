data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_virtual_network" "vnet" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.vnet_name
  resource_group_name = var.rg_name
}
data "azurerm_network_security_group" "nsg" {
  depends_on = [azurerm_network_security_group.nsg]

  name                = azurerm_network_security_group.nsg.name
  resource_group_name = azurerm_network_security_group.nsg.resource_group_name
}
data "azurerm_subnet" "snet" {
  depends_on = [data.azurerm_virtual_network.vnet]

  name                 = var.snet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}
