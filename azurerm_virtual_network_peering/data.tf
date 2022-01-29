data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_virtual_network" "vnet" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.vnet_name
  resource_group_name = var.rg_name
}
data "azurerm_resource_group" "rg_dst" {
  provider = "azurerm.${var.provider_dst}"

  name = var.rg_name_dst
}
data "azurerm_virtual_network" "vnet_dst" {
  provider = "azurerm.${var.provider_dst}"

  name                = var.vnet_name_dst
  resource_group_name = var.rg_name_dst
}
