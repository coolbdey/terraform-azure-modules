locals {
  default_database = var.sqlserver.default_database == null ? "master" : var.sqlserver.default_database
  default_language = var.sqlserver.default_language == null ? "us_english" : var.sqlserver.default_language
  host             = "${var.sqlserver.name}.database.windows.net"
}