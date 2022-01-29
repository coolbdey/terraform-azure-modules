variable "name" {}
variable "enterprise" {
  type        = bool
  description = "Create a service principal for an enterprise application, or else for an application"
  default     = false
}
variable "description" {
  type        = string
  description = " (Optional) A description of the service principal provided for internal end-users."
  default     = ""
}
variable "rotation_days" {
  type        = number
  description = "(Optional) A map of arbitrary key/value pairs that will force recreation of the password when they change, enabling password rotation based on external conditions such as a rotating timestamp. Changing this forces a new resource to be created."
  default     = 365
}
