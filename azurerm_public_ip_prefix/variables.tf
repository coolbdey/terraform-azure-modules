variable "name" {}
variable "lock_resource" {
  type        = bool
  description = "Adds lock level CanNotDelete to the resource"
  default     = false
}
variable "rg_name" {}
variable "prefix_length" {
  type        = number
  description = "(Optional) Specifies the number of bits of the prefix. Choices are 28(16 addresses), 29(8 addresses), 30(4 addresses) or 30(2 addresses). Changing this forces a new resource to be created."
  default     = 29
}
variable "ip_version" {
  type        = string
  description = " (Optional) The IP Version to use, IPv6 or IPv4. Changing this forces a new resource to be created. Default is IPv4"
  default     = "IPv4"
  validation {
    condition     = contains(["IPv4", "IPv6"], var.ip_version)
    error_message = "Variable \"ip_version\" must either be \"IPv4\", or \"IPv6\"."
  }
}
variable "sku" {
  type        = string
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. When sku_tier is set to Global, sku must be set to Standard"
  default     = "Standard"
}
variable "availability_zone" {
  type        = string
  description = "(Optional) The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone. Defaults to Zone-Redundant."
  default     = "Zone-Redundant"
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
