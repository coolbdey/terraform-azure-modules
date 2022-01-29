variable "name" {}
variable "lock_resource" {
  type        = bool
  description = "Adds lock level CanNotDelete to the resource"
  default     = false
}
variable "rg_name" {}
variable "nsg_rg_name" {}
variable "nsg_name" {}

variable "ip_configurations" {
  type = list(object({
    name               = string
    subnet_id          = string
    ipaddr_allocation  = string
    private_ip_address = string
    primary            = bool
  }))
  description = "(Required) One or more ip_configuration blocks as defined below"
  default     = []
}
variable "dns_servers" {
  type        = list(string)
  description = "(Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface. Configuring DNS Servers will override the DNS Servers defined on the Virtual Network."
  default     = []
}
variable "enable_ip_forwarding" {
  type        = bool
  description = "(Optional) Should IP Forwarding be enabled? Defaults to false"
  default     = false
}
variable "internal_dns_name_label" {
  type        = string
  description = " (Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network."
  default     = null
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
