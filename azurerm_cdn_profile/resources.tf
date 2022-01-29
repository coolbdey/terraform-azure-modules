resource "azurerm_cdn_profile" "cdnp" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location         # Norwayeast is not valid, choose Northeurope or global
  sku                 = "Standard_Microsoft" #"Standard_Verizon"
  tags                = var.tags
  lifecycle {
    ignore_changes = [tags["updated_date"], location]
  }
}
