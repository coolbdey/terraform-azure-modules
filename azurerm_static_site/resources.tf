resource "azurerm_static_site" "ss" {
  depends_on = [
    data.azurerm_resource_group.rg
  ]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size
  tags                = var.tags

  identity {
    type = "SystemAssigned"
    identity_ids = var.identity_ids
  }

}
