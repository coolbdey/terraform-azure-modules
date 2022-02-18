## azurerm_monitor_metric_alert

### Module resources
---

* https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert
* https://docs.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-common-schema?WT.mc_id=Portal-Microsoft_Azure_Monitoring

### Module usage
---

```
locals {
    environment  = terraform.workspace
    rg_name = "__ENTER_VALUE__"
    re_tags = {
        created_by   = "FirstName LastName"
        created_date = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())
        environment  = local.environment
        managed_by   = "Terraform"
    }
    
    # Metrics alert for App Service Plan Memory
    ma_asp_name       = "${title(local.environment)} - App Service Plan - Memory-70"
    ma_asp_desc       = "Warn whenever the memory is over 70 percent for the last 6 hours"
    ma_asp_severity   = 2
    ma_asp_frequency  = "PT5M"
    ma_asp_windowsize = "PT5M"
    ma_asp_actions = [{
        action_group_id    = module.action_group_ops.id
        webhook_properties = null
    }]
    ma_asp_scopes = [module.app_service_plan.id]
    ma_asp_criteria = [{
        metric_namespace = "Microsoft.Web/serverfarms"
        metric_name      = "MemoryPercentage"
        aggregation      = "Average"
        operator         = "GreaterThan"
        threshold        = 70
        dimension        = []
        }
    ]
    ma_asp_dynamic_criteria = []

}

module "resource_group" {
  source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_resource_group"

  ...
}

module "app_service_plan" {
  source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_app_service_plan"
  depends_on = [module.resource_group]

  ...
}

module "action_group_ops" {
  source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_monitor_action_group"
  depends_on = [module.app_service_plan]

  ...
}

# Alerts for App Service Plan Memory
module "metric_alert_asp" {
  source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_monitor_metric_alert"
  depends_on = [module.action_group_ops]

  name             = local.ma_asp_name
  enabled          = true 
  rg_name          = local.rg_name
  scopes           = toset(local.ma_asp_scopes)
  description      = local.ma_asp_desc
  criterias         = local.ma_asp_criteria
  dynamic_criterias = local.ma_asp_dynamic_criteria
  severity         = local.ma_asp_severity
  frequency        = local.ma_asp_frequency
  window_size      = local.ma_asp_windowsize
  actions          = local.ma_asp_actions
  tags             = local.re_tags
}

```