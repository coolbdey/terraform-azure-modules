data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_app_configuration" "appc" {
  depends_on = [azurerm_app_configuration.appc]

  name                = var.name
  resource_group_name = var.rg_name
}
