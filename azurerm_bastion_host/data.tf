data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_resource_group" "vnet_rg" {
  name = var.vnet_rg_name
}
data "azurerm_subnet" "snet" {
  depends_on = [data.azurerm_resource_group.vnet_rg]

  name                 = var.snet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg_name
}
