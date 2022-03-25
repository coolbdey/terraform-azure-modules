variable "name" {}
variable "rg_name" {}
variable "vnet_name" {}
variable "remote_virtual_network_id" {}

variable "allow_virtual_network_access" {
  type        = bool
  description = "Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true."
  default     = true
}
variable "allow_forwarded_traffic" {
  type        = bool
  description = "Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. Defaults to true."
  default     = true
}

variable "allow_gateway_transit" {
  type        = bool
  description = " (Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network."
  default     = false
}

variable "allow_remote_gateways" {
  type        = bool
  description = "(Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Defaults to false"
  default     = false
}