variable "name" {}
variable "lock_resource" {
  type        = bool
  description = "Adds lock level CanNotDelete to the resource"
  default     = false
}
variable "rg_name" {}
variable "pipp_name" {
  type        = string
  description = "The Public IP Prefixes name if used"
  default     = null
}
variable "pipp_rg_name" {}
variable "allocation_method" {
  type        = string
  description = "(Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic"
  default     = "Static"
}
variable "sku" {
  type        = string
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. When sku_tier is set to Global, sku must be set to Standard"
  default     = "Standard"
}
variable "idle_timeout_in_minutes" {
  type        = number
  description = "(Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  default     = 10
}
variable "sku_tier" {
  type        = string
  description = "(Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional"
  default     = "Regional"
}
variable "availability_zone" {
  type        = string
  description = "(Optional) The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone. Defaults to Zone-Redundant."
  default     = "Zone-Redundant"
}
variable "domain_name_label" {
  type        = string
  description = "Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system. Will be applied to .<location>.cloudapp.azure.com."
  default     = null
}
variable "ip_version" {
  type        = string
  description = " (Optional) The IP Version to use, IPv6 or IPv4. Default is IPv4"
  default     = "IPv4"
  validation {
    condition     = contains(["IPv4", "IPv6"], var.ip_version)
    error_message = "Variable \"ip_version\" must either be \"IPv4\", or \"IPv6\"."
  }
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
