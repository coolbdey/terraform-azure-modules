data "azuread_client_config" "current" {}

data "azurerm_mssql_server" "sql" {
  name                = var.sql_name
  resource_group_name = var.rg_name
}

data "azurerm_mssql_database" "db" {
  name      = var.db_name
  server_id = data.azurerm_mssql_server.sql.id

  depends_on = [data.azurerm_mssql_server.sql]
}