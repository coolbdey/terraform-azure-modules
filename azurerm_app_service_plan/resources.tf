resource "azurerm_app_service_plan" "asp" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  kind                = var.kind
  per_site_scaling    = var.per_site_scaling
  reserved            = lower(var.kind) == "linux" ? true : null
  zone_redundant      = var.zone_redundant

  sku {
    tier     = var.tier
    size     = var.size
    capacity = var.capacity
  }

  tags = var.tags
  lifecycle {
    ignore_changes        = [tags["updated_date"], location]
    create_before_destroy = true
  }
}
