resource "azurerm_app_configuration" "appc" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = var.sku
  tags                = var.tags

  lifecycle {
    ignore_changes = [tags, location]
  }
}
