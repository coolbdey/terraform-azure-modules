resource "azurerm_network_security_group" "nsg" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = var.tags

  lifecycle {
    ignore_changes = [tags["update_date"], location, name]
  }
}

resource "azurerm_network_security_rule" "nsg_rule_inbound" {
  depends_on = [azurerm_network_security_group.nsg]
  count      = try(length(var.nsg_rules_inbound), 0)

  name                        = var.nsg_rules_inbound[count.index].name
  priority                    = try(var.nsg_rules_inbound[count.index].priority, 100)
  direction                   = "Inbound"
  access                      = try(var.nsg_rules_inbound[count.index].access, "Allow")                 # Allow | Deny
  protocol                    = try(var.nsg_rules_inbound[count.index].protocol, "*")                   # Tcp | Udp | *
  source_port_range           = try(var.nsg_rules_inbound[count.index].source_port_range, "*")          # 1-65NNN | *
  destination_port_range      = try(var.nsg_rules_inbound[count.index].destination_port_range, "*")     # IP | CIDR | *
  source_address_prefix       = try(var.nsg_rules_inbound[count.index].source_address_prefix, "*")      # IP | CIDR | *
  destination_address_prefix  = try(var.nsg_rules_inbound[count.index].destination_address_prefix, "*") # IP | CIDR | *
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "nsg_rule_outbound" {
  depends_on = [azurerm_network_security_group.nsg]
  count      = try(length(var.nsg_rules_outbound), 0)

  name                        = var.nsg_rules_outbound[count.index].name
  priority                    = try(var.nsg_rules_outbound[count.index].priority, 100)
  direction                   = "Outbound"
  access                      = try(var.nsg_rules_outbound[count.index].access, "Allow")                 # Allow | Deny
  protocol                    = try(var.nsg_rules_outbound[count.index].protocol, "*")                   # Tcp | Udp | *
  source_port_range           = try(var.nsg_rules_outbound[count.index].source_port_range, "*")          # 1-65NNN | *
  destination_port_range      = try(var.nsg_rules_outbound[count.index].destination_port_range, "*")     # IP | CIDR | *
  source_address_prefix       = try(var.nsg_rules_outbound[count.index].source_address_prefix, "*")      # IP | CIDR | *
  destination_address_prefix  = try(var.nsg_rules_outbound[count.index].destination_address_prefix, "*") # IP | CIDR | *
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet_network_security_group_association" "nsga" {
  depends_on = [azurerm_network_security_group.nsg]

  subnet_id                 = data.azurerm_subnet.snet.id
  network_security_group_id = azurerm_network_security_group.nsg.id

  lifecycle {
    ignore_changes = [subnet_id, network_security_group_id]
  }
}
