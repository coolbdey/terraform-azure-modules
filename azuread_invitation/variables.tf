variable "name" {
  type        = string
  description = "value"

  validation {
    condition     = can(regex("[a-zA-Z- ]+ [a-zA-Z.]+", var.name))
    error_message = "Variable \"name\" must either be a valid name (Firstname Lastname)."
  }
}
variable "email" {
  type        = string
  description = "value"

  validation {
    condition     = can(regex("^[0-9a-z_\\-.]+@[a-z0-9\\-_]+\\.[a-z]{2,}$", var.email))
    error_message = "Variable \"email\" must be a valid email address."
  }
}
variable "recipients" {
  type        = list(string)
  description = " (Optional) Email addresses of additional recipients the invitation message should be sent to. Only 1 additional recipient is currently supported by Azure."
  default     = []
}
variable "body" {
  type        = string
  description = " (Optional) Customized message body you want to send if you don't want to send the default message. Cannot be specified with language."
  default     = "Hello there!. You are invited to join Azure tenant!"
}
variable "redirect_url" {
  type        = string
  description = "(Required) The URL that the user should be redirected to once the invitation is redeemed."
  default     = "https://portal.azure.com"
}
variable "user_type" {
  type        = string
  description = " (Optional) The user type of the user being invited. Must be one of Guest or Member. Only Global Administrators can invite users as members. Defaults to Guest."
  default     = "Guest"

  validation {
    condition     = contains(["Guest", "Member"], var.user_type)
    error_message = "Variable \"user_type\" must either be \"Guest\" or \"Member\"."
  }
}
