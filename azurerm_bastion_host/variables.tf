variable "name" {}
variable "lock_resource" {
  type        = bool
  description = "Adds lock level CanNotDelete to the resource"
  default     = false
}
variable "rg_name" {}
variable "snet_id" {
  type        = string
  description = "(Required) Reference to a subnet in which this Bastion Host has been created. The Subnet used for the Bastion Host must have the name AzureBastionSubnet and the subnet mask must be at least a /26."
  validation {
    condition     = can(regex("AzureBastionSubnet", var.snet_id))
    error_message = "The subnet name used for variable 'snet_name' must be named AzureBastionSubnet and the subnet mask must be at least a /26."
  }
}

variable "sku" {
  type        = string
  description = "(Optional) The SKU of the Bastion Host. Accepted values are Basic and Standard. Defaults to Basic."
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Basic"], var.sku)
    error_message = "Variable \"sku\" must either be \"Basic\", or \"Standard\"."
  }
}
variable "public_ip_id" {
  type        = string
  description = "The ID of the Public IP resource"
}
variable "copy_paste_enabled" {
  type        = bool
  description = "(Optional) Is Copy/Paste feature enabled for the Bastion Host. Defaults to true."
  default     = true
}
variable "file_copy_enabled" {
  type        = bool
  description = "(Optional) Is File feature enabled for the Bastion Host. Defaults to false."
  default     = false
}
variable "ip_connect_enabled" {
  type        = bool
  description = "(Optional) Is IP Connect feature enabled for the Bastion Host. Defaults to false."
  default     = false
}

variable "scale_units" {
  type        = number
  description = "(Optional) The number of scale units with which to provision the Bastion Host. Possible values are between 2 and 50. Defaults to 2."
  default     = 2
  validation {
    condition     = var.scale_units >= 2 && var.scale_units <= 50
    error_message = "Variable 'scale_units' must be a number between 2 and 50."
  }
}
variable "shareable_link_enabled" {
  type        = bool
  description = "(Optional) Is Shareable Link feature enabled for the Bastion Host. Defaults to false."
  default     = false
}
variable "tunneling_enabled" {
  type        = bool
  description = "(Optional) Is Tunneling feature enabled for the Bastion Host. Defaults to false."
  default     = false
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
