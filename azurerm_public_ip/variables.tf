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
  validation {
    condition     = can(regex(["Static|Dynamic"], var.allocation_method))
    error_message = "Variable 'allocation_method' must either be Static (Default) or Dynamic."
  }
}
variable "sku" {
  type        = string
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. When sku_tier is set to Global, sku must be set to Standard"
  default     = "Standard"
  validation {
    condition     = can(regex(["Standard|Basic"], var.sku))
    error_message = "Variable 'sku' must either be Standard (Default) or Basic."
  }
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
  validation {
    condition     = can(regex(["Regional|Basic"], var.sku_tier))
    error_message = "Variable 'sku_tier' must either be Regional (Default) or Global."
  }
}
variable "domain_name_label" {
  type        = string
  description = "Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system. Will be applied to .<location>.cloudapp.azure.com."
  default     = null
}
variable "reverse_fqdn" {
  type        = string
  description = "(Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."
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
variable "zones" {
  type       = list(string)
  description = "(Optional) A collection containing the availability zone to allocate the Public IP in."
  default     = []
}
variable "edge_zone" {
  type       = string
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. Changing this forces a new Public IP to be created."
  default     = null
}
variable "ip_tags" {
  type        = map(any)
  description = "(Optional) A mapping of IP tags to assign to the public IP."
  default     = {}
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}