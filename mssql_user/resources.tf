# https://registry.terraform.io/providers/betr-io/mssql/latest/docs/resources/user
resource "mssql_user" "db_user" {
  depends_on = [azurerm_mssql_database.db]

  server {
    host = "${var.sql_name}.database.windows.net"
    port = var.port
    azure_login {
      tenant_id     = var.tenant_id
      client_id     = var.client_id
      client_secret = var.client_secret
    }
  }
  database         = var.db_name
  username         = var.name
  login_name       = var.login_name
  roles            = var.roles
  default_schema   = var.default_schema   #"dbo"
  default_language = var.default_language # us_english

  #login {
  # username = var.databases[count.index].username
  # password = var.databases[count.index].password
  #}
}
