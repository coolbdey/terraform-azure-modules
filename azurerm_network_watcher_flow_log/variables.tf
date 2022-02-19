variable "name" {}
variable "rg_name" {}
variable "enabled" {
  type        = bool
  description = "(Required) Should Network Flow Logging be Enabled? Default is true."
  default     = true
}
variable "nw_name" {
  type        = string
  description = " (Required) The name of the Network Watcher. Changing this forces a new resource to be created."
}
variable "nsg_id" {
  type        = string
  description = "(Required) The ID of the Network Security Group for which to enable flow logs for. Changing this forces a new resource to be created."
}
variable "sa_id" {
  type        = string
  description = "(Required) The ID of the Storage Account where flow logs are stored."
}

variable "version" {
  type        = number
  description = "(Optional) The version (revision) of the flow log. Possible values are 1 and 2."
  default     = 2
  validation {
    condition     = var.version >= 1 && var.version <= 2
    error_message = "Variable 'version' must be 1 or 2."
  }
}
variable "retention_policy" {
  type = list(object({
    enabled = bool
    days    = number
  }))
  description = "(Required) A retention_policy to retain flow log records"
}
variable "traffic_analytics" {
  type = list(object({
    enabled               = bool
    workspace_id          = string
    workspace_region      = string
    workspace_resource_id = string
    interval_in_minutes   = number

  }))
  description = "(Required) A retention_policy to retain flow log records"
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}