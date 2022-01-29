data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_resource_group" "vnet_rg" {
  name = var.vnet_rg_name
}
data "azurerm_virtual_network" "vnet" {
  depends_on = [data.azurerm_resource_group.vnet_rg]

  name                = var.vnet_name
  resource_group_name = var.vnet_rg_name
}
data "azurerm_subnet" "snet" {
  depends_on = [data.azurerm_virtual_network.vnet]

  name                 = var.snet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg_name
}
data "azurerm_resource_group" "pipa_rg" {
  name = var.pipa_rg_name
}
data "azurerm_public_ip" "pipa" {
  depends_on = [data.azurerm_resource_group.pipa_rg]

  name                = var.pipa_name
  resource_group_name = var.pipa_rg_name
}
