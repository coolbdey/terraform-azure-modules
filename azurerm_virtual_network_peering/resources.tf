resource "azurerm_virtual_network_peering" "vnetp" {
  depends_on = [data.azurerm_virtual_network.vnet, data.azurerm_virtual_network.vnet_dst]

  name                         = var.name
  resource_group_name          = var.rg_name
  virtual_network_name         = var.vnet_name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_dst.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

