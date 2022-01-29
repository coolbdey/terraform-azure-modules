variable "vnet_name" {}
variable "rg_name" {}
#variable "subnets" {}

variable "subnets" {
  type = list(object({
    name       = string
    cidr       = list(string)
    tags       = list(string)
    endpoints  = list(string)
    delegation = list(string)
  }))
  description = "Subnet names, cidr prefixes, service endpoints and subnet deligation"
}

variable "delegation_actions" {
  type        = list(string)
  description = "value"
  default = [
    "Microsoft.Network/networkinterfaces/*",
    "Microsoft.Network/virtualNetworks/subnets/action",
    "Microsoft.Network/virtualNetworks/subnets/join/action",
    "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
    "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
  ]
}
