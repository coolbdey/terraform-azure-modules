resource "azurerm_static_site" "ss" {
  depends_on = [
    data.azurerm_resource_group.rg
  ]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size
  tags                = var.tags

}
