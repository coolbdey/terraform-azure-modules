data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_resource_group" "pipp_rg" {
  count = var.pipp_name == null ? 0 : 1
  name  = var.pipp_rg_name
}
data "azurerm_public_ip_prefix" "pipp" {
  depends_on = [data.azurerm_resource_group.pipp_rg]
  count      = var.pipp_name == null ? 0 : 1

  name                = var.pipp_name
  resource_group_name = var.pipp_rg_name
}
data "azurerm_public_ip" "pipa" {
  depends_on = [azurerm_public_ip.pipa]

  name                = var.name
  resource_group_name = var.rg_name
}

