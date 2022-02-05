variable "name" {}
variable "rg_name" {}
variable "per_site_scaling" {
  type        = bool
  description = "Can Apps assigned to this App Service Plan be scaled independently? If set to false apps assigned to this plan will scale to all instances of the plan."
  default     = false
}
variable "kind" {
  type        = string
  description = "The kind of the App Service Plan to create. Possible values are Windows (also available as App), Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan). Changing this forces a new resource to be created."
  default     = "Windows"
  validation {
    condition     = contains(["Windows", "Linux", "Elastic"], var.kind)
    error_message = "Variable \"app_kind\" must either be \"Windows\", \"Linux\" or \"Elastic\"."
  }
}
variable "tier" {
  type        = string
  description = "Specifies the plan's pricing tier"
  default     = "Standard"
}
variable "size" {
  type        = string
  description = "Specifies the plan's instance size"
  default     = "S1"
}
variable "capacity" {
  type        = number
  description = "Specifies the number of workers associated with this App Service Plan."
  default     = 2
}

variable "zone_redundant" {
  type = string
  description = "(Optional) Specifies if the App Service Plan should be Zone Redundant. Changing this forces a new resource to be created. Defaults to false. Requires either PremiumV2 or PremiumV3 SKU and that at least 3 instances if true. "
  default = false
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
