resource "azurerm_network_watcher" "nw" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = var.tags

  lifecycle {
    ignore_changes = [location]
  }
}

