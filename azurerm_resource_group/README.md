
### Module usage
---


```
locals {
    rg_name = ""
    rg_tags = {
        created_by   = "FirstName LastName"
        created_date = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())
        environment  = terraform.workspace
        managed_by   = "Terraform"
    }
    rg_lock_resource = false
    rg_location = "norwayeast"
}

module "resource_group" {
  source     = "github.com/sysco-middleware/terraform-azure-modules.git/azurerm_resource_group"
  #source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_resource_group?ref=main"
  #source     = "github.com/sysco-middleware/terraform-azure-modules.git/azurerm_resource_group?ref=v1.0.0"

  name          = local.rg_name
  tags          = local.rg_tags
  location      = local.rg_location
  lock_resource = local.rg_lock_resource
}

```