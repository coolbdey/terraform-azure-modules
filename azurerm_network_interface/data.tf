data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_network_interface" "nic" {
  depends_on = [azurerm_network_interface.nic]

  name                = var.name
  resource_group_name = var.rg_name
}
data "azurerm_resource_group" "nsg_rg" {
  name = var.nsg_rg_name
}
data "azurerm_network_security_group" "nsg" {
  depends_on = [data.azurerm_resource_group.nsg_rg]

  name                = var.nsg_name
  resource_group_name = var.nsg_rg_name
}
