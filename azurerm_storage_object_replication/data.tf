data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_storage_account" "sa" {
  name                = var.sa_name
  resource_group_name = var.rg_name
}

data "azurerm_resource_group" "rg_dst" {
  provider = azurerm.secure
  count    = length(var.containers) > 0 ? 1 : 0

  name = var.rg_dst_name
}
data "azurerm_storage_account" "sa_dst" {
  provider = azurerm.secure
  count    = length(var.containers) > 0 ? 1 : 0

  name                = var.sa_dst_name
  resource_group_name = var.rg_dst_name
}
