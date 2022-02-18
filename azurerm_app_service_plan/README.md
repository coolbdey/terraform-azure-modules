## azurerm_app_service_plan

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
    
    asp_name = "__ENTER_VALUE__"
    sku = {
        asp_kind     = "StorageV2"
        asp_tier     = "Standard"
        asp_size     = "S0"
        asp_capacity = 1
    }
        
}

module "resource_group" {
  source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_resource_group"

  ...
}

module "app_service_plan" {
  source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_app_service_plan"
  depends_on = [module.resource_group]

  name             = local.asp_name
  rg_name          = local.rg_name
  per_site_scaling = true
  kind             = local.sku.asp_kind
  tier             = local.sku.asp_tier
  size             = local.sku.asp_size
  capacity         = local.sku.asp_capacity
  tags             = local.re_tags
}


```

### Module troubleshoot
---

