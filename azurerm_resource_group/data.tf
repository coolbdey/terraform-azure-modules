data "azurerm_resource_group" "rg" {
  name = var.name

  depends_on = [azurerm_resource_group.rg]
}
