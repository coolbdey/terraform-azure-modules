# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database
resource "azurerm_mssql_database" "db" {
  depends_on = [data.azurerm_mssql_server.sql, data.azurerm_storage_account.sa]
  count      = length(var.databases)

  name                 = var.databases[count.index].database
  server_id            = data.azurerm_mssql_server.sql.id
  collation            = var.collation
  license_type         = "LicenseIncluded"
  read_scale           = false # read_scale is not supported for Stardard (S0..) skus
  sku_name             = var.sku_name
  geo_backup_enabled   = false # Not supported in Norway East
  zone_redundant       = false # Not supported in Norway East
  storage_account_type = var.storage_account_type
  tags                 = var.tags
  #elastic_pool_id - (Optional) Specifies the ID of the elastic pool containing this database.
  #max_size_gb          = var.max_size_gb

  short_term_retention_policy {
    retention_days = var.pit_retention_days
  }

  long_term_retention_policy {
    weekly_retention  = "P1W" # (Optional) The weekly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 520 weeks. e.g. P1Y, P1M, P1W or P7D.
    monthly_retention = "P1M" # (Optional) The monthly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 120 months. e.g. P1Y, P1M, P4W or P30D.
    yearly_retention  = "P1M" # (Optional) The yearly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 10 years. e.g. P1Y, P12M, P52W or P365D.
    week_of_year      = 3     # (Optional) The week of year to take the yearly backup in an ISO 8601 format. Value has to be between 1 and 52.
  }

  threat_detection_policy {
    state                      = var.tdp_enabled
    disabled_alerts            = ["Access_Anomaly", "Sql_Injection", "Sql_Injection_Vulnerability"]
    email_account_admins       = "Disabled"
    email_addresses            = []
    retention_days             = var.tdal_retention_days
    storage_account_access_key = data.azurerm_storage_account.sa.primary_access_key    # Required if state is Enabled.
    storage_endpoint           = data.azurerm_storage_account.sa.primary_blob_endpoint # Required if state is Enabled.
  }

  lifecycle {
    ignore_changes = [tags["updated_date"], storage_account_type, server_id, license_type, geo_backup_enabled, threat_detection_policy]
  }
}

resource "azurerm_mssql_database_extended_auditing_policy" "policy" {
  depends_on = [azurerm_mssql_database.db]
  count      = length(var.databases)

  database_id                             = azurerm_mssql_database.db[count.index].id
  storage_endpoint                        = data.azurerm_storage_account.sa.primary_blob_endpoint
  storage_account_access_key              = data.azurerm_storage_account.sa.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = var.log_retension_days
  # Log analytics: https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/sql-azure/sql_auditing_log_analytics
  # Event hub: https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/sql-azure/sql_auditing_eventhub
  # Azure Monitor
  log_monitoring_enabled = var.log_monitoring_enabled

  lifecycle {
    ignore_changes = [database_id]
  }
}

# https://registry.terraform.io/providers/betr-io/mssql/latest/docs/resources/login
## TODO:  Error: unable to update login [*]: db connection failed after 30s timeout
resource "mssql_login" "sql_login" {
  depends_on = [data.azurerm_mssql_server.sql]
  count      = length(var.databases)
  server {
    host = local.host
    port = 1433
    #login {
    #  username = var.sql_admin_user
    #  password = var.sql_admin_pass
    #}
    azure_login {
      tenant_id     = var.tenant_id
      client_id     = var.client_id
      client_secret = var.client_secret
    }
  }
  login_name       = var.sqlserver.login_name
  password         = var.sqlserver.password
  default_database = local.default_database
  default_language = local.default_language
}

# https://registry.terraform.io/providers/betr-io/mssql/latest/docs/resources/user
resource "mssql_user" "db_user" {
  depends_on = [mssql_login.sql_login]
  count      = length(var.databases)

  server {
    host = local.host
    port = 1433
    azure_login {
      tenant_id     = var.tenant_id
      client_id     = var.client_id
      client_secret = var.client_secret
    }
    #login {
    #  username = var.sqlserver.login_name
    #  password = var.sqlserver.password
    # object_id # (Optional) The object id of the external username. Only used in azure_login auth context when AAD role delegation to sql server identity is not possible.
    #}
  }
  database         = var.databases[count.index].database
  username         = var.databases[count.index].username == null ? var.databases[count.index].login_name : var.databases[count.index].username
  login_name       = var.databases[count.index].login_name
  password         = var.databases[count.index].password
  roles            = var.databases[count.index].roles
  default_schema   = var.databases[count.index].default_schema == null ? "dbo" : var.databases[count.index].default_schema
  default_language = var.databases[count.index].default_language == null ? "us_english" : var.databases[count.index].default_language
}


resource "azurerm_key_vault_secret" "kv_secret_db_pass" {
  depends_on = [data.azurerm_key_vault.kv]
  count      = length(var.databases)

  name         = var.databases[count.index].kv_secret.name
  value        = var.databases[count.index].kv_secret.value
  content_type = "Azure SQL Database connectionstring"

  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [key_vault_id]
  }
}
