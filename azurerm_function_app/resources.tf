# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app
resource "azurerm_function_app" "fa" {
  depends_on = [
    data.azurerm_resource_group.rg,
    data.azurerm_app_service_plan.asp,
  data.azurerm_storage_account.sa]

  enabled                    = var.enabled
  name                       = var.name
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  app_service_plan_id        = data.azurerm_app_service_plan.asp.id
  https_only                 = var.https_only
  os_type                    = var.os_type
  enable_builtin_logging     = var.enable_builtin_logging
  storage_account_name       = data.azurerm_storage_account.sa.name
  storage_account_access_key = data.azurerm_storage_account.sa.primary_access_key
  client_cert_mode           = var.client_cert_mode
  version                    = "~3" # ~1 | ~3
  tags                       = var.tags

  app_settings = local.app_settings

  dynamic "connection_string" {
    for_each = length(var.connection_strings) > 0 ? var.connection_strings : []
    iterator = each
    content {
      name  = each.value.name
      type  = each.value.type
      value = each.value.conn
    }
  }

  #This fails
  identity {
    type = "SystemAssigned"
  }

  site_config {
    #acr_use_managed_identity_credentials - (Optional) Are Managed Identity Credentials used for Azure Container Registry pull
    always_on = true #  (Optional) Should the app be loaded at all times? Must be set to false when App Service Plan in the Free or Shared Tiers  Defaults to false
    # app_command_line - (Optional) App command line to launch, e.g. /sbin/myserver -b 0.0.0.0.

    #Cross-Origin Resource Sharing (CORS) allows JavaScript code running in a browser on an external host to interact with your backend. Specify the origins that should be allowed to make cross-origin calls (for example: http://example.com:12345). To allow all, use "*" and remove all other origins from the list. 
    #Slashes are not allowed as part of domain or after TLD. Learn more
    #cors {
    #  allowed_origins     = ["*"] # A list of origins which should be able to make cross-origin calls
    #  support_credentials = true
    #}
    # dotnet_framework_version:
    ## (Optional) The version of the .net framework's CLR used in this App Service. 
    ## Possible values are v2.0 (which will use the latest version of the .net framework for the .net CLR v2 - currently .net 3.5), 
    ## v4.0 (which corresponds to the latest version of the .net CLR v4 - which at the time of writing is .net 4.7.1), v5.0 and v6.0
    #dotnet_framework_version = local.dotnet_framework_version
    #linux_fx_version         = local.linux_fx_version
    health_check_path         = var.health_check_path
    min_tls_version           = "1.2"
    websockets_enabled        = false
    http2_enabled             = true # (Optional) Specifies whether or not the http2 protocol should be enabled. Defaults to false
    use_32_bit_worker_process = var.use_32_bit_worker_process
    scm_type                  = "None" # LocalGit | None
    ftps_state                = var.ftps_state
  }

  lifecycle {
    ignore_changes = [tags["updated_date"], location, app_settings, site_config["scm_type"], storage_account_access_key]
  }
}
