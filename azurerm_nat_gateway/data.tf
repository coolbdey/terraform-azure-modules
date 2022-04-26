data "azurerm_client_config" "current" {}

##################################
######## NAT Gateway

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_nat_gateway" "natg" {
  depends_on = [azurerm_nat_gateway.natg]

  name                = var.name
  resource_group_name = var.rg_name
}

##################################
######## Network

data "azurerm_resource_group" "vnet_rg" {
  name = var.vnet_rg_name
}
data "azurerm_virtual_network" "vnet" {
  depends_on = [data.azurerm_resource_group.vnet_rg]

  name                = var.vnet_name
  resource_group_name = var.vnet_rg_name
}
data "azurerm_subnet" "snet" {
  depends_on = [data.azurerm_virtual_network.vnet]
  count      = length(var.snet_names)

  name                 = var.snet_names[count.index]
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg_name
}

##################################
######## Public IP Address

data "azurerm_resource_group" "pipa_rg" {
  count = length(var.natgpiaa_objects)

  name = var.natgpiaa_objects[count.index].rg_name
}
data "azurerm_public_ip" "pipa" {
  depends_on = [data.azurerm_resource_group.pipa_rg]
  count      = length(var.natgpiaa_objects)

  name                = var.natgpiaa_objects[count.index].name
  resource_group_name = var.natgpiaa_objects[count.index].rg_name
}

##################################
######## Public IP Prefix

data "azurerm_resource_group" "pipp_rg" {
  count = length(var.natgpipa_objects)

  name = var.natgpipa_objects[count.index].rg_name
}
data "azurerm_public_ip_prefix" "pipp" {
  depends_on = [data.azurerm_resource_group.pipp_rg]
  count      = length(var.natgpipa_objects)

  name                = var.natgpipa_objects[count.index].name
  resource_group_name = var.natgpipa_objects[count.index].rg_name
}
