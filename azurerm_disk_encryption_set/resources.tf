resource "azurerm_disk_encryption_set" "des" {
  depends_on = [data.azurerm_resource_group.rg]

  name                      = var.name
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = data.azurerm_resource_group.rg.location
  key_vault_key_id          = var.kv_key_id
  auto_key_rotation_enabled = var.auto_key_rotation_enabled
  encryption_type           = var.encryption_type
  tags                      = var.tags

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [location]
  }
}

/*
resource "azurerm_role_assignment" "role" {
  depends_on = [azurerm_disk_encryption_set.des]

  scope                = var.kv_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_disk_encryption_set.des.identity.0.principal_id
}
*/