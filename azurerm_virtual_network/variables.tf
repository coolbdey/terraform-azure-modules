variable "name" {}
variable "rg_name" {}
variable "location" {
  type        = string
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created. Uses resource group location by default"
  default     = null
}
variable "ddospp_id" {
  type        = string
  description = "DDOS protection plan id. By default not configured"
  default     = null
}
variable "ddospp_enabled" {
  type        = bool
  description = "Azure DDoS Protection plan is very expensive. https://azure.microsoft.com/en-us/pricing/calculator/. Only one resource supported per Subscription"
  default     = false
}
variable "address_space" {
  type        = list(string)
  description = "(Required) A list of address spaces that is used the virtual network. At least one is required."
}
variable "use_azure_dns" {

}
variable "dns_servers" {
  type        = list(string)
  description = "Since dns_servers can be configured both inline and via the separate azurerm_virtual_network_dns_servers resource, we have to explicitly set it to empty slice ([]) to remove it."
  default     = []
}
variable "flow_timeout_in_minutes" {
  type        = string
  description = "(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes."
  default     = 4
}
variable "subnets" {
  type = list(object({
    name              = string # (Required) The name of the subnet.
    address_prefix    = string # (Required) The address prefix to use for the subnet.
    security_group_id = string # (Optional) The Network Security Group to associate with the subnet. (Referenced by id, ie. azurerm_network_security_group.example.id)
  }))
  description = "(Optional) Can be specified multiple times to define multiple subnets. Each subnet block supports fields documented below. Since subnet can be configured both inline and via the separate azurerm_subnet resource, we have to explicitly set it to empty slice ([]) to remove it."
  default     = []
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
