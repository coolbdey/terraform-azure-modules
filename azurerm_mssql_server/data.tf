data "azuread_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}
data "azurerm_storage_account" "sa" {
  name                = var.sa_name
  resource_group_name = var.rg_name
}

data "azurerm_mssql_server" "sql" {
  name                = var.name
  resource_group_name = var.rg_name

  depends_on = [azurerm_mssql_server.sql]
}

