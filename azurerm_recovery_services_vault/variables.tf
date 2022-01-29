
variable "name" {}
variable "location" {}
variable "rg_name" {}
variable "soft_delete_enabled" {
  type        = bool
  description = " (Optional) Is soft delete enable for this Vault? Defaults to true."
  default     = true
}
variable "sku" {
  type        = string
  description = "(Required) Sets the vault's SKU. Possible values include: Standard, RS0. Defaults to Standard"
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "RS0"], var.sku)
    error_message = "Variable \"sku\" must either be \"Standard\" or \"RS0\"."
  }
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
