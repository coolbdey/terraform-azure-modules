variable "name" {}

variable "vm_ids" {
  type        = list(string)
  description = "(Required) The IDs of the Virtual Machines. Changing this forces a new resource to be created"
}

variable "publisher" {
  type        = string
  description = "(Required) The publisher of the extension, available publishers can be found by using the Azure CLI. Changing this forces a new resource to be created."
  #default     = "Microsoft.Azure.Extensions"
}

variable "type" {
  type        = string
  description = "(Required) The type of extension, available types for a publisher can be found using the Azure CLI."
  #default     = "CustomScript"
}

variable "type_handler_version" {
  type        = string
  description = "(Required) The type of extension, available types for a publisher can be found using the Azure CLI."
  #default     = "2.0"
}

variable "auto_upgrade_minor_version" {
  type        = bool
  description = "(Optional) Specifies if the platform deploys the latest minor version update to the type_handler_version specified"
  default     = true
}

variable "automatic_upgrade_enabled" {
  type        = bool
  description = "(Optional) Should the Extension be automatically updated whenever the Publisher releases a new version of this VM Extension? Defaults to false."
  default     = false
}

variable "settings_map" {
  type        = map(any)
  description = "(Required) The settings passed to the extension. Note: The map will be converted  as a JSON object in a string using jsonencode."
  #default = {
  #  fileUris = "http:/ddd/hello.sh"
  #  commandToExecute = "./hello.sh"
  #}
}

variable "protected_settings_map" {
  type        = map(any)
  description = "(Optional) The protected_settings passed to the extension. Note: The map will be converted  as a JSON object in a string using jsonencode."
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}