# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group
resource "azuread_group" "owner" {
  depends_on = [data.azuread_client_config.current]

  display_name     = var.aad_group.owner
  mail_enabled     = false
  security_enabled = true
  description      = "Terraform: ${var.group_type} ${var.application} owner for ${var.environment}"
  owners           = [data.azuread_client_config.current.object_id]
  #mail_nickname    = var.aad_group.owner # BUG: Having this defined cause replaced (destroyed) on every terraform apply
  prevent_duplicate_names = var.prevent_duplicate_names

  # https://www.terraform.io/docs/language/meta-arguments/lifecycle.html
  lifecycle {
    ignore_changes = var.ignore_changes # mail_nickname will cause a replacement
  }
}
resource "azuread_group" "contributor" {
  depends_on = [data.azuread_client_config.current]

  display_name     = var.aad_group.contributor
  mail_enabled     = false
  security_enabled = true
  description      = "Terraform: ${var.group_type} ${var.application} contributor for ${var.environment}"
  owners           = [data.azuread_client_config.current.object_id]
  #mail_nickname    = var.aad_group.owner # BUG: Having this defined cause replaced (destroyed) on every terraform apply
  prevent_duplicate_names = var.prevent_duplicate_names
  lifecycle {
    ignore_changes = var.ignore_changes
  }
}

resource "azuread_group" "reader" {
  depends_on = [data.azuread_client_config.current]

  display_name = var.aad_group.reader
  #mail_nickname    = var.aad_group.owner # BUG: Having this defined cause replaced (destroyed) on every terraform apply
  mail_enabled            = false
  security_enabled        = true
  description             = "Terraform: ${var.group_type} ${var.application} reader for ${var.environment}"
  owners                  = [data.azuread_client_config.current.object_id]
  prevent_duplicate_names = var.prevent_duplicate_names

  lifecycle {
    ignore_changes = var.ignore_changes
  }
}

#### MEMBERS
# WARNING: Do not use the members property in azuread_group at the same time as the azuread_group_member resource for the same group. 
# Doing this so will cause a conflict and group members will be removed.

resource "azuread_group_member" "contributor" {
  depends_on = [azuread_group.contributor, data.azuread_users.members]
  count      = length(var.members) == 0 ? 0 : length(data.azuread_users.members.object_ids)

  group_object_id  = azuread_group.contributor.id
  member_object_id = data.azuread_users.members.object_ids[count.index]

  lifecycle {
    ignore_changes = [group_object_id, member_object_id]
  }
}
