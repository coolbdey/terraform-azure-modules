output "ids" {
  description = "The IDs of the MS SQL Databases."
  #value       = values(data.azurerm_mssql_database.db)[*].id # When using for_each
  value = [for item in data.azurerm_mssql_database.db : item.id] # Ehen using for
}

output "master_id" {
  value = data.azurerm_mssql_database.master.id
}

output "names" {
  description = "The Names of the MS SQL Databases."
  #value       = values(data.azurerm_mssql_database.db)[*].name
  value = [for item in data.azurerm_mssql_database.db : item.name]
}

output "connectionstrings" {
  description = "Connectionstring for the Azure SQL Database created."
  value = [
    for item in var.databases_cur :
  "Server=tcp:${data.azurerm_mssql_server.sql.fully_qualified_domain_name},1433;Initial Catalog=${item.database};Persist Security Info=False;User ID=${item.username};Password=${item.password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"]

  sensitive = true
}

output "metric_namespace" {
  description = "The Resource Metric namespace"
  value       = "Microsoft.Sql/servers/databases"
}