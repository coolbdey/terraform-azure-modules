variable "name" {}
variable "rg_name" {}

variable "vm_id" {
  type        = string
  description = "(Required) The ID of the Virtual Machine. Changing this forces a new resource to be created"
}

variable "publisher" {
  type        = string
  description = "(Required) The publisher of the extension, available publishers can be found by using the Azure CLI. Changing this forces a new resource to be created."
  default     = "Microsoft.Azure.Extensions"
}

variable "type" {
  type        = string
  description = "(Required) The type of extension, available types for a publisher can be found using the Azure CLI."
  default     = "CustomScript"
}

variable "type_handler_version" {
  type        = string
  description = "(Required) The type of extension, available types for a publisher can be found using the Azure CLI."
  default     = "2.0"
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

variable "settings_json" {
  type        = string
  description = "(Required) The settings passed to the extension, these are specified as a JSON object in a string."
  default     = <<EOF
    {
        "commandToExecute": "hostname && uptime"
    }
EOF
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}