# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database
resource "azurerm_cosmosdb_mongo_database" "mongo" {
  depends_on = [data.azurerm_cosmosdb_account.cdba]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  account_name        = data.azurerm_cosmosdb_account.cdba.name
  throughput          = var.throughout

  #autoscale_settings {
  #max_throughput  = #  (Optional) The maximum throughput of the MongoDB database (RU/s). Must be between 4,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput.
  #}
}
