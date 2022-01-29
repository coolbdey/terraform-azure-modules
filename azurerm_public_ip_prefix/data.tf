data "azuread_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_public_ip_prefix" "pipp" {
  depends_on = [azurerm_public_ip_prefix.pipp]

  name                = var.name
  resource_group_name = var.rg_name
}
