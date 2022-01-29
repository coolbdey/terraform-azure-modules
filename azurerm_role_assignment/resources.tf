# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "role" {
  depends_on = [data.azuread_group.ra_group]

  scope                = var.scope_id
  role_definition_name = var.name
  principal_id         = data.azuread_group.ra_group.object_id

  lifecycle {
    ignore_changes = [scope, principal_id]
  }
}

resource "azuread_group_member" "member" {
  depends_on = [data.azuread_group.role_group, data.azuread_group.ra_group]
  count      = var.role_group_name == "" ? 0 : 1

  group_object_id  = data.azuread_group.ra_group[count.index].object_id
  member_object_id = data.azuread_group.role_group[count.index].object_id

  lifecycle {
    ignore_changes = [member_object_id, group_object_id]
  }
}
