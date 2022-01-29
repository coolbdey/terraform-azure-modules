variable "name" {}
variable "lock_resource" {
  type        = bool
  description = "Adds lock level CanNotDelete to the resource"
  default     = false
}
variable "rg_name" {}
variable "vnet_name" {}
variable "vnet_rg_name" {}
variable "snet_name" {}

variable "sku" {
  type        = string
  description = "(Optional) The SKU of the Bastion Host. Accepted values are Basic and Standard. Defaults to Basic."
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "BAsic"], var.sku)
    error_message = "Variable \"sku\" must either be \"Basic\", or \"Standard\"."
  }
}
variable "public_ip_id" {
  type        = string
  description = "The ID of the Public IP resource"
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
