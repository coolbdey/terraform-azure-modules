

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_ddos_protection_plan
resource "azurerm_network_ddos_protection_plan" "dpp" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.dpp_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  lifecycle {
    ignore_changes = [location]
  }
}

resource "azurerm_network_watcher" "nw" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.nw_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  lifecycle {
    ignore_changes = [location]
  }
}

resource "azurerm_virtual_network" "vnet" {
  depends_on = [data.azurerm_resource_group.rg, azurerm_network_ddos_protection_plan.dpp]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = var.address_space
  dns_servers         = local.dns_servers
  tags                = var.tags

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.dpp.id
    enable = var.dpp_enabled
  }

  lifecycle {
    ignore_changes = [tags["updated_date"], location]
  }
}

