data "azurerm_resource_group" "rg" {
  name = var.name

  depends_on = [azurerm_resource_group.rg]
}

data "azuread_users" "members" {
  count = length(var.contributor_members) > 1 ? 1 : 0

  user_principal_names = var.contributor_members

  ignore_missing = true
}
