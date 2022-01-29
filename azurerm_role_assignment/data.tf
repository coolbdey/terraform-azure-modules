data "azuread_client_config" "current" {}
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group
data "azuread_group" "ra_group" {
  display_name     = var.ra_group_name
  security_enabled = true
}
data "azuread_group" "role_group" {
  count = var.role_group_name == "" ? 0 : 1

  display_name     = var.role_group_name
  security_enabled = true
}
