# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_instance_blob_storage
resource "azurerm_data_protection_backup_vault" "dpbv" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  datastore_type      = var.datastore_type
  redundancy          = var.redundancy

  identity {
    type = "SystemAssigned" #  (Required) Specifies the identity type of the Backup Vault. Possible value is SystemAssigned.
  }

  lifecycle {
    ignore_changes = [tags["updated_date"], location]
  }
}

resource "azurerm_role_assignment" "ra" {
  depends_on = [data.azurerm_storage_account.sa, azurerm_data_protection_backup_vault.dpbv]

  scope                = data.azurerm_storage_account.sa.id
  role_definition_name = "Storage Account Backup Contributor Role"
  principal_id         = azurerm_data_protection_backup_vault.dpbv.identity.0.principal_id

  lifecycle {
    ignore_changes = [principal_id]
  }
}

resource "azurerm_data_protection_backup_policy_blob_storage" "policy" {
  depends_on = [azurerm_data_protection_backup_vault.dpbv]

  name               = "storage-policy"
  vault_id           = azurerm_data_protection_backup_vault.dpbv.id
  retention_duration = var.retention_duration

  lifecycle {
    ignore_changes = [vault_id]
  }
}

resource "azurerm_data_protection_backup_instance_blob_storage" "instance" {
  depends_on = [azurerm_role_assignment.ra, azurerm_data_protection_backup_policy_blob_storage.policy]

  name               = "${var.sa_name}-instance"
  vault_id           = azurerm_data_protection_backup_vault.dpbv.id
  location           = data.azurerm_resource_group.rg.location
  storage_account_id = data.azurerm_storage_account.sa.id
  backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.policy.id

  lifecycle {
    ignore_changes = [location]
  }
}

