data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_servicebus_namespace" "sbns" {
  depends_on = [azurerm_servicebus_namespace.sbns]

  name                = var.name
  resource_group_name = var.rg_name
}
