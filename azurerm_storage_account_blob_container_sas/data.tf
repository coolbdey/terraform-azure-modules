data "azuread_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_storage_account" "sa" {
  name                = var.sa_name
  resource_group_name = var.rg_name
}

data "azurerm_storage_container" "container" {
  name                 = var.name
  storage_account_name = var.sa_name
}

data "azurerm_storage_account_blob_container_sas" "sas" {
  depends_on = [data.azurerm_storage_account.sa]

  container_name    = var.name
  connection_string = data.azurerm_storage_account.sa.primary_connection_string
  https_only        = true

  #ip_address = "168.1.5.65"

  start  = var.time_start  #  The starting time and date of validity of this SAS. Must be a valid ISO-8601 format time/date string.
  expiry = var.time_expire # The expiration time and date of this SAS. Must be a valid ISO-8601 format time/date string.

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }

  cache_control       = "max-age=5"
  content_disposition = "inline"
  content_encoding    = "deflate"
  content_language    = "en-US"
  content_type        = "application/json"
}
