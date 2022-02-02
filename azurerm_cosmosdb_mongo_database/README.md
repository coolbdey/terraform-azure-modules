
### Module usage
---


```
locals {
    rg_name         = "__ENTER_VALUE__"
    cdba_name       = "__ENTER_VALUE__"
    cdba_mongo_name = "__ENTER_VALUE__"
}

module "resource_group" {
  ...
}

module "cosmosdb_account" {
  depends_on = [module.resource_group]
  ...
}

module "cosmosdb_mongo_database" {
  depends_on = [module.cosmosdb_account]  
  source     = "github.com/sysco-middleware/terraform-azure-modules.git/azurerm_cosmosdb_mongo_database"
  #source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_cosmosdb_mongo_database?ref=main"
  #source     = "github.com/sysco-middleware/terraform-azure-modules.git//azurerm_cosmosdb_mongo_database?ref=v1.0.0"

  name          = local.cdba_mongo_name
  rg_name       = local.rg_name
  cdba_name     = local.cdba_name
}

```

### Module info
---

Terraform Doc: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account_mongo_database
