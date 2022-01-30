# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
resource "azurerm_cosmosdb_account" "cdba" {
  depends_on = [data.azurerm_resource_group.rg]

  name                          = var.name
  resource_group_name           = data.azurerm_resource_group.rg.name
  location                      = data.azurerm_resource_group.rg.location
  offer_type                    = var.offer_type
  kind                          = var.kind
  public_network_access_enabled = var.public_enabled

  enable_automatic_failover = true

  dynamic "capabilities" {
    for_each = length(var.capabilities) > 0 ? var.capabilities : []
    iterator = each
    content {
      name = each.value
    }
  }

  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = var.failover_location
    failover_priority = 1
  }

  geo_location {
    location          = data.azurerm_resource_group.rg.location
    failover_priority = 0
  }
  tags = var.tags
}