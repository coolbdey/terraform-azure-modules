resource "azurerm_monitor_diagnostic_setting" "mds" {
  depends_on = [data.azurerm_mssql_database.db, data.azurerm_log_analytics_workspace.law]

  name                       = var.name
  target_resource_id         = data.azurerm_mssql_database.db.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id

  log {
    category = "SQLSecurityAuditEvents"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }

  lifecycle {
    ignore_changes = [log, metric]
  }
}
