#https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/invitation

resource "azuread_invitation" "inv" {
  user_display_name  = var.name
  user_email_address = var.email
  redirect_url       = var.redirect_url

  message {
    additional_recipients = ["alex@aof.no"]
    body                  = "Hello there! ${var.name}. You are invited to join Azure tenant!"
  }
}
