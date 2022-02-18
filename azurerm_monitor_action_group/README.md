## azurerm_monitor_action_group

### Module resources
---

* https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group

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
    
    ag_name = "Operations"
    ag_webhook_url = "__ENTER_VALUE__"    
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

# Action groups for Operations 
module "action_group_ops" {
  source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_monitor_action_group"
  depends_on = [module.app_service_plan]

  name       = local.ag_name
  rg_name    = local.rg_name
  short_name = "operations"
  email_receiver = [
    {
      name                    = "SendMailToMe"
      email_address           = "firstname.lastname@domain.com"
      use_common_alert_schema = false
    },
    {
      name                    = "SendMailToSupport"
      email_address           = "support@domain.com"
      use_common_alert_schema = true
    }
  ]
  webhook_receiver = [
    {
      name                    = "SendToWebHook"
      service_uri             = local.ag_webhook_url
      use_common_alert_schema = true
    }
  ]
}

```