

output "id" {
  value = data.azurerm_mssql_server.sql.id
}

output "fqdn" {
  value = data.azurerm_mssql_server.sql.fully_qualified_domain_name
}

/*
output "sql_admin_group" {
  description = "The login username of the Azure AD Administrator of this SQL Server."
  #value       = data.azurerm_mssql_server.sql.login_username
  value = data.azurerm_mssql_server.sql.login_username
}
*/

output "sql_admin_group_object_id" {
  description = "The object id of the Azure AD Administrator of this SQL Server."
  #value       = data.azurerm_mssql_server.sql.object_id
  value = data.azurerm_mssql_server.sql.id
}

output "administrator_login" {
  description = "Azure SQL server administrator login"
  value       = azurerm_mssql_server.sql.administrator_login
}

output "administrator_login_password" {
  description = "Azure SQL server administrator login"
  value       = azurerm_mssql_server.sql.administrator_login_password
  sensitive   = true
}

output "location" {
  description = "Location of the Azure SQL Database created."
  value       = azurerm_mssql_server.sql.location
}
output "version" {
  description = "Version the Azure SQL Database created."
  value       = azurerm_mssql_server.sql.version
}

