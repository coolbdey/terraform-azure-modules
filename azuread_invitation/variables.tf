variable "name" {
  type        = string
  description = "The name of the invitation"

  validation {
    rule          = regexmatch("/[a-z- ]+ [a-z.]+/", self)
    error_message = "Variable \"name\" must be a valid name (Firstname Lastname)."
    examples      = ["FirstName Lastname"]
  }
}
variable "email" {
  type        = string
  description = "The email of the invitation"

  validation {
    rule          = regexmatch("/[a-z.]+@[a-z.]+/", self)
    error_message = "Variable \"email\" must be a valid email address."
    examples      = ["bob.andersen@domain.no"]
  }
}
variable "redirect_url" {
  type = string

  default = "https://portal.azure.com"
}
