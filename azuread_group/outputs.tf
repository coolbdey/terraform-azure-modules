output "member_ids" {
  description = "role member users"
  #value       = [for x in data.azuread_users.members : x.object_id]
  value = data.azuread_users.members.object_ids
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