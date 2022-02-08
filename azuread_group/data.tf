data "azuread_client_config" "current" {}
#data "azuread_client_config" "current" {}
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users
data "azuread_users" "members_contr" {
  user_principal_names = var.members_contr

  ignore_missing = true
}
data "azuread_users" "members_owner" {
  user_principal_names = var.members_owner

  ignore_missing = true
}
data "azuread_users" "members_readr" {
  user_principal_names = var.members_readr

  ignore_missing = true
}
