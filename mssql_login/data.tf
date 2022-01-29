data "azuread_client_config" "current" {}
data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}
data "azurerm_mssql_server" "sql" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.sql_name
  resource_group_name = var.rg_name
}
