/*
module "storage_account_container_sas" {
  depends_on = [azurerm_storage_container.container]
  source = "../azurerm_storage_account_blob_container_sas"

  for_each = toset(local.sa_containers)

  name        = each.key
  rg_resource_group_name = var.rg_name
  sa_name     = var.sa_name
  time_start  = timestamp()
  time_expire = timeadd(timestamp(), "1h01m")
}
*/
