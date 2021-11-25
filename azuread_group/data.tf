
data "azuread_client_config" "current" {}
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users
data "azuread_users" "members" {
  user_principal_names = var.members

  ignore_missing = true
}

