locals {
  appsettings_default = {
    WEBSITE_RUN_FROM_PACKAGE        = 1
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = true
    WEBSITE_TIME_ZONE               = var.time_zone
  }
  appsettings_appinsights = var.app_insights.enabled ? {
    APPINSIGHTS_INSTRUMENTATIONKEY             = var.app_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING      = var.app_insights.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
  } : {}
  app_settings = merge(local.appsettings_default, local.appsettings_appinsights, var.app_settings)

  identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? toset(var.managed_identity_ids) : null

  is_consumption_plan = can(regex("Y1", data.azurerm_service_plan.sp.sku_name)) || can(regex("FunctionApp", data.azurerm_service_plan.sp.kind))
}
