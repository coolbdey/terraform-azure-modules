data "azurerm_client_config" "current" {}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_storage_account" "sa" {
  depends_on = [azurerm_storage_account.sa]

  name                = var.name
  resource_group_name = var.rg_name
}

