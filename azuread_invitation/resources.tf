#https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/invitation

resource "azuread_invitation" "invite" {
  user_display_name  = var.name
  user_email_address = var.email
  redirect_url       = var.redirect_url
  user_type          = var.user_type

  # (Optional) A message block as documented below, which configures the message being sent to the invited user. If this block is omitted, no message will be sent.
  message {
    additional_recipients = var.recipients
    body                  = var.body
    #language           = "en-US" # Cannot be specified with body. Invitation with standard message
  }

  lifecycle {
    ignore_changes = [message]
  }
}
