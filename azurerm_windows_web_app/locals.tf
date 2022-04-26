locals {
  # https://docs.microsoft.com/en-us/azure/azure-functions/run-functions-from-deployment-package
  # https://www.how2code.info/en/blog/website_dynamic_cache-and-website_local_cache_option/
  appsettings_default = {
    WEBSITE_DYNAMIC_CACHE           = "0"
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

  #default_documents = sort(["index.html", "index.js", "default.html", "default.aspx", "hostingstart.htm", "iisstart.htm"])
  identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? toset(var.managed_identity_ids) : null

  dotnet_version         = can(regex("dotnet", var.current_stack)) ? var.dotnet_version : null
  java_container         = can(regex("java", var.current_stack)) ? var.java_container : null
  java_version           = can(regex("java", var.current_stack)) ? var.java_version : null
  java_container_version = can(regex("java", var.current_stack)) ? var.java_container_version : null
  php_version            = can(regex("php", var.current_stack)) ? var.php_version : null
  python_version         = can(regex("python", var.current_stack)) ? var.python_version : null
  node_version           = can(regex("node", var.current_stack)) ? var.node_version : null

  ftps_state = var.application_logs.enabled ? "FtpsOnly" : var.ftps_state
}
