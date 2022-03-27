variable "name" {}
variable "rg_name" {}
variable "subnet_id" {}
variable "psc_name" {
  type        = string
  description = "(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created."
}
variable "psc_ismanual" {
  type        = bool
  description = "(Required) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
  default     = false
}
variable "psc_pcr_id" {
  type        = string
  description = "(Optional) The Private Service Connection ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified. Changing this forces a new resource to be created. For a web app or function app slot, the parent web app should be used in this field instead of a reference to the slot itself."
  default     = null
}
variable "psc_pcr_alias" {
  type        = string
  description = "(Optional) The Private Service Connection Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified. Changing this forces a new resource to be created."
  default     = null
}
variable "psc_subresource_names" {
  type        = list(string)
  description = "(Optional) A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id. Changing this forces a new resource to be created."
  default     = ["managedInstance", "blob", "file", "queue", "table", "web", "sites", "sqlServer"]
}
variable "psc_request_message" {
  type        = string
  description = "(Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. One of private_connection_resource_id or private_connection_resource_alias must be specified. Changing this forces a new resource to be created."
  default     = "PL"
}
