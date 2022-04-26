locals {
  default_database = var.sqlserver.default_database == null ? "master" : var.sqlserver.default_database
  default_language = var.sqlserver.default_language == null ? "us_english" : var.sqlserver.default_language
  host             = "${var.sqlserver.name}.database.windows.net"

  log_monitoring_enabled = var.auditing_enabled ? true : var.log_monitoring_enabled

  databases_cur = [
    for item in var.databases :
    {
      database         = item.database
      username         = item.username == null ? item.login_name : item.username
      login_name       = item.login_name
      password         = item.password
      roles            = item.roles
      default_schema   = item.default_schema == null ? "dbo" : item.default_schema
      default_language = item.default_language == null ? "us_english" : item.default_language

    }
  ]
}