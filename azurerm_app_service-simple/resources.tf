# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
resource "azurerm_app_service" "wa" {
  depends_on = [
    data.azurerm_resource_group.rg,
    data.azurerm_app_service_plan.asp,
  ]

  enabled                 = var.enabled
  name                    = var.name
  resource_group_name     = data.azurerm_resource_group.rg.name
  location                = data.azurerm_resource_group.rg.location
  app_service_plan_id     = data.azurerm_app_service_plan.asp.id
  client_affinity_enabled = var.client_affinity_enabled
  client_cert_enabled     = var.client_cert_enabled
  https_only              = var.https_only
  tags                    = var.tags

  app_settings = local.app_settings

  site_config {
    always_on                 = true #  (Optional) Should the app be loaded at all times? Must be set to false when App Service Plan in the Free or Shared Tiers  Defaults to false
    dotnet_framework_version  = local.dotnet_framework_version
    linux_fx_version          = local.linux_fx_version
    windows_fx_version        = local.windows_fx_version
    managed_pipeline_mode     = "Integrated"
    min_tls_version           = "1.2"
    websockets_enabled        = false
    http2_enabled             = true # (Optional) Specifies whether or not the http2 protocol should be enabled. Defaults to false
    use_32_bit_worker_process = var.use_32_bit_worker_process
    scm_type                  = "None" # LocalGit | None
    ftps_state                = var.ftps_state
    default_documents         = local.default_documents
  }

  dynamic "auth_settings" {
    for_each = length(var.auth_settings) > 0 ? var.auth_settings : []
    iterator = each
    content {
      enabled          = each.value.enabled
      default_provider = each.value.provider
      active_directory {
        client_id         = each.value.active_directory.client_id     # (Required) The Client ID of this relying party application. Enables OpenIDConnection authentication with Azure Active Directory.
        client_secret     = each.value.active_directory.client_secret # (Optional) The Client Secret of this relying party application. If no secret is provided, implicit flow will be used.
        allowed_audiences = each.value.active_directory.audiences
      }
    }
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 30
        retention_in_mb   = 100
      }
    }
  }

  lifecycle {
    ignore_changes = [location, app_settings]
  }
}
