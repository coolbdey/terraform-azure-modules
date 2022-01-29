# https://registry.terraform.io/providers/betr-io/mssql/latest/docs/resources/login
## TODO:  Error: unable to update login [namedb]: db connection failed after 30s timeout
resource "mssql_login" "sql_login" {
  depends_on = [data.azurerm_mssql_server.sql]

  server {
    host = "${var.sql_name}.database.windows.net"
    port = var.port
    azure_login {
      tenant_id     = var.tenant_id
      client_id     = var.client_id
      client_secret = var.client_secret
    }
  }
  login_name       = var.login_name # (Required) The name of the server login. Changing this forces a new resource to be created.
  password         = var.password
  default_database = var.default_database # (Optional) The default database of this server login. Defaults to master. This argument does not apply to Azure SQL Database.
  default_language = var.default_language # Optional) The default language of this server login. Defaults to us_english. This argument does not apply to Azure SQL Database.
}
