# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering
resource "azurerm_virtual_network_peering" "vnetp" {
  depends_on = [data.azurerm_virtual_network.vnet]

  name                         = var.name
  resource_group_name          = var.rg_name
  virtual_network_name         = var.vnet_name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  allow_remote_gateways        = var.allow_remote_gateways
}

