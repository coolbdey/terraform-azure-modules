
resource "azurerm_bastion_host" "bas" {
  depends_on = [data.azurerm_resource_group.rg, data.azurerm_subnet.snet]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = var.sku
  tags                = var.tags

  ip_configuration {
    name                 = "${var.name}-ip_configuration"
    subnet_id            = data.azurerm_subnet.snet.id
    public_ip_address_id = var.public_ip_id
  }
  lifecycle {
    ignore_changes = [tags["updated_date"], location, ip_configuration["subnet_id"]]
  }
}

resource "azurerm_management_lock" "kv_lock" {
  depends_on = [azurerm_bastion_host.bas]
  count      = var.lock_resource ? 1 : 0

  name       = "CanNotDelete"
  scope      = azurerm_bastion_host.bas.id
  lock_level = "CanNotDelete"
  notes      = "Terraform: This prevents accidental deletion if this resource"
}
