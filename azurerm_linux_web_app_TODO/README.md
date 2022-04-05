## azurerm_app_service

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

  ...
}

```

### Module troubleshoot
---

│ Error: updating Storage Accounts for App Service "*": web.AppsClient#UpdateAzureStorageAccounts: Failure sending request: StatusCode=409 -- Original Error: autorest/azure: Service returned an error. Status=<nil> <nil>      
│
│   with module.app_service_signicat.azurerm_app_service.as,
│   on ..\..\..\modules\azurerm_app_service\resources.tf line 11, in resource "azurerm_app_service" "as":
│   11: resource "azurerm_app_service" "as" {

    
activate this service.

    https://social.msdn.microsoft.com/Forums/azure/en-US/454d64c5-4e30-48dc-b205-2e51bf72b56c/why-api-management-service-take-too-long-to-get-activated?forum=azureapimgmt