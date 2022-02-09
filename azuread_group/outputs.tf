output "member_ids_owner" {
  description = "Member object ids for the owner users"
  value       = data.azuread_users.members_owner.object_ids
}

output "member_ids_contr" {
  description = "Member object ids for the contributor users"
  value       = data.azuread_users.members_contr.object_ids
}

output "member_ids_readr" {
  description = "Member object ids for the reader users"
  #value       = [for x in data.azuread_users.members : x.object_id]
  value = data.azuread_users.members_readr.object_ids
}

output "owner_id" {
  description = "Owner role id"
  value       = azuread_group.owner.object_id
}

output "contributor_id" {
  description = "Contributor role id"
  value       = azuread_group.contributor.object_id
}

output "reader_id" {
  description = "Reader role id"
  value       = azuread_group.reader.object_id
}