# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights
resource "azurerm_application_insights" "appi" {
  depends_on = [data.azurerm_resource_group.rg]

  name                                  = var.name
  resource_group_name                   = data.azurerm_resource_group.rg.name
  location                              = data.azurerm_resource_group.rg.location
  workspace_id                          = var.law_workspace_id
  application_type                      = var.application_type
  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = true # (Optional) Specifies if a notification email will be send when the daily data volume cap is met.
  retention_in_days                     = var.retention_in_days
  disable_ip_masking                    = false # (Optional) By default the real client ip is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client ip. 
  local_authentication_disabled         = false # (Optional) Disable Non-Azure AD based Auth. Defaults to false
  tags                                  = var.tags

  lifecycle {
    ignore_changes = [tags["updated_date"], location]
  }
}
