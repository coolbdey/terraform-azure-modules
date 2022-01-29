variable "name" {}
variable "rg_name" {}
variable "vnet_name" {}
variable "snet_name" {}

variable "nsg_rules_inbound" {
  type = list(object({
    name                       = string
    priority                   = number
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "Network security group inbound rules"
  default     = []
}
variable "nsg_rules_outbound" {
  type = list(object({
    name                       = string
    priority                   = number
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "Network security group outbound rules. Name property is required"
  default     = []
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
