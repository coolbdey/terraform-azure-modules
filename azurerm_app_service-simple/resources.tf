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
    scm_type                  = "None"     # LocalGit | None
    ftps_state                = "Disabled" # AllAllowed | FtpsOnly | Disabled 
    default_documents         = local.default_documents
    #virtual_network_name      = var.vnet_name

    /*
    ip_restriction {
      name = "${var.snet_name}-restriction" # (Optional) The name for this IP Restriction.
      # ip_address - (Optional) The IP Address used for this IP Restriction in CIDR notation.
      # service_tag - (Optional) The Service Tag used for this IP Restriction.
      virtual_network_subnet_id = data.azurerm_subnet.snet.id
      action                    = "Allow" #- (Optional) Does this restriction Allow or Deny access for this IP range. Defaults to Allow.
      #headers {} - (Optional) The headers for this specific ip_restriction as defined below.
    }
    vnet_route_all_enabled = false #- (Optional) Should all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied? Defaults to false
    */
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
