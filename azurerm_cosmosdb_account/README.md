
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

module "cosmosdb_account" {
  source     = "github.com/sysco-middleware/terraform-azure-modules.git/azurerm_cosmosdb_account"
  #source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_cosmosdb_account?ref=main"
  #source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_cosmosdb_account?ref=v1.0.0"

  name          = local.rg_name
  tags          = local.rg_tags
  location      = local.rg_location
  lock_resource = local.rg_lock_resource
}

```

### Module info
---

Terraform Doc: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
Installation duration: 8-9 minutes
Destroy duration: 4-5 minutes