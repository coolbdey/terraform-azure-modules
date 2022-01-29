data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_data_protection_backup_vault" "dpbv" {
  depends_on = [azurerm_data_protection_backup_vault.dpbv]

  name                = var.name
  resource_group_name = var.rg_name
}

data "azurerm_storage_account" "sa" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.sa_name
  resource_group_name = var.rg_name
}
