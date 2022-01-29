output "object_id" {
  description = "Object ID of the invited user"
  value       = azuread_invitation.invite.user_id
}
output "redeem_url" {
  description = "The URL the user can use to redeem their invitation."
  value       = azuread_invitation.invite.redeem_url
}
output "user_display_name" {
  description = "The display name of the user being invited."
  value       = azuread_invitation.invite.user_display_name
}
output "user_email_address" {
  description = "The email address of the user being invited."
  value       = azuread_invitation.invite.user_email_address
}

