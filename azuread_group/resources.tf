# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group
resource "azuread_group" "owner" {
  depends_on = [data.azuread_client_config.current]

  display_name     = var.aad_group.owner
  mail_enabled     = false
  security_enabled = true
  description      = var.description_owner
  owners           = [data.azuread_client_config.current.object_id]
  #mail_nickname    = var.aad_group.owner # BUG: Having this defined cause replaced (destroyed) on every terraform apply
  prevent_duplicate_names = var.prevent_duplicate_names

  # https://www.terraform.io/docs/language/meta-arguments/lifecycle.html
  lifecycle {
    ignore_changes = [members, owners]
  }
}
resource "azuread_group" "contributor" {
  depends_on = [data.azuread_client_config.current]

  display_name     = var.aad_group.contributor
  mail_enabled     = false
  security_enabled = true
  description      = var.description_contr
  owners           = [data.azuread_client_config.current.object_id]
  #mail_nickname    = var.aad_group.owner # BUG: Having this defined cause replaced (destroyed) on every terraform apply
  #members                 = data.azuread_users.members.object_ids
  prevent_duplicate_names = var.prevent_duplicate_names
  lifecycle {
    ignore_changes = [members, owners]
  }
}

resource "azuread_group" "reader" {
  depends_on = [data.azuread_client_config.current]

  display_name = var.aad_group.reader
  #mail_nickname    = var.aad_group.owner # BUG: Having this defined cause replaced (destroyed) on every terraform apply
  mail_enabled            = false
  security_enabled        = true
  description             = var.description_readr
  owners                  = [data.azuread_client_config.current.object_id]
  prevent_duplicate_names = var.prevent_duplicate_names

  lifecycle {
    ignore_changes = [members, owners]
  }
}


#### MEMBERS
# WARNING: Do not use the members property in azuread_group at the same time as the azuread_group_member resource for the same group. 
# Doing so will cause a conflict and group members will be removed.


resource "azuread_group_member" "owner" {
  depends_on = [azuread_group.owner, data.azuread_users.members_owner]
  count      = length(var.members_owner)

  group_object_id  = azuread_group.contributor.id
  member_object_id = data.azuread_users.members_owner.object_ids[count.index]

  lifecycle {
    ignore_changes = [group_object_id, member_object_id]
  }
}

resource "azuread_group_member" "contributor" {
  depends_on = [azuread_group.contributor, data.azuread_users.members_contr]
  count      = length(var.members_contr)

  group_object_id  = azuread_group.contributor.id
  member_object_id = data.azuread_users.members_contr.object_ids[count.index]

  lifecycle {
    ignore_changes = [group_object_id, member_object_id]
  }
}

resource "azuread_group_member" "reader" {
  depends_on = [azuread_group.reader, data.azuread_users.members_readr]
  count      = length(var.members_readr)

  group_object_id  = azuread_group.reader.id
  member_object_id = data.azuread_users.members_readr.object_ids[count.index]

  lifecycle {
    ignore_changes = [group_object_id, member_object_id]
  }
}

