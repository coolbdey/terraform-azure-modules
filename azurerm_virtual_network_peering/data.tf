data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_virtual_network" "vnet" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.vnet_name
  resource_group_name = var.rg_name
}
