variable "name" {}
variable "description" {
  type        = string
  description = "The description of the metric. Default is null."
  default     = null
}
variable "rg_name" {}
variable "enabled" {
  type        = bool
  description = "(Optional) Should this Metric Alert be enabled? Defaults to true."
  default     = true
}
variable "auto_mitigate" {
  type        = bool
  description = "(Optional) Should the alerts in this Metric Alert be auto resolved? Defaults to true"
  default     = true
}

variable "scopes" {
  type        = set(string)
  description = "(Required) A set of strings of resource IDs at which the metric criteria should be applied. Note: use toset([..])."
}

variable "frequency" {
  type        = string
  description = "(Optional) The evaluation frequency of this Metric Alert, represented in ISO 8601 duration format. Possible values are PT1M, PT5M, PT15M, PT30M and PT1H. Defaults to PT1M."
  default     = "PT1M"
}

variable "severity" {
  type        = number
  description = "(Optional) The severity of the alert after the criteria specified in the alert rule is met. Possible values are 0 (Critical), 1 (Error), 2 (Warning), 3 (Informational) and 4 (Verbose). Defaults to 3."
  default     = 3
  validation {
    condition     = var.severity >= 0 && var.severity <= 5
    error_message = "Variable \"frequency\" must be a number from 0 to 4. Default is 3 (Informational)."
  }
}

variable "target_resource_type" {
  type        = string
  description = "(Optional) The resource type (e.g. Microsoft.Compute/virtualMachines) of the target resource. This is Required when using a Subscription as scope, a Resource Group as scope or Multiple Scopes."
  default     = null
}

variable "target_resource_location" {
  type        = string
  description = "(Optional) The location of the target resource. This is Required when using a Subscription as scope, a Resource Group as scope or Multiple Scopes."
  default     = null
}

variable "criteria" {
  type = list(object({
    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number
    dimension = list(object({
      name     = string
      operator = string
      values   = list(string)
    }))
  }))
  description = "one or up to five combination of signal and logic applied on a target resource. Note: One of either criteria, dynamic_criteria or aiwtla_criteria must be specified."
  default     = []
  validation {
    condition     = length(var.criteria) <= 5
    error_message = "Variable 'criteria' must have zero or up to five list items."
  }
}

variable "dynamic_criteria" {
  type = list(object({
    metric_namespace         = string
    metric_name              = string
    aggregation              = string
    operator                 = string
    alert_sensitivity        = string
    evaluation_total_count   = number
    evaluation_failure_count = number
    ignore_data_before       = string
    skip_metric_validation   = bool
    dimension = list(object({
      name     = string
      operator = string
      values   = list(string)
    }))
  }))
  description = "One combination dynamic criteria. Note: One of either criteria, dynamic_criteria or aiwtla_criteria must be specified."
  default     = []
  validation {
    condition     = length(var.dynamic_criteria) <= 1
    error_message = "Variable 'dynamic_criteria' must have zero or one list item."
  }
}

variable "aiwtla_criteria" {
  type = list(object({
    web_test_id           = string
    component_id          = string
    failed_location_count = number
  }))
  description = "One combination Application Insights Web Test location availability criteria. Note: One of either criteria, dynamic_criteria or aiwtla_criteria must be specified."
  default     = []
  validation {
    condition     = length(var.aiwtla_criteria) <= 1
    error_message = "Variable 'aiwtla_criteria' must have zero or one list item."
  }
}

variable "actions" {
  type = list(object({
    action_group_id    = string
    webhook_properties = object(any) #(Optional) The map of custom string properties to include with the post operation. These data are appended to the webhook payload.
  }))
  description = "Monitor action Group Ids and webhook properties (if used)."
  default     = []
}

variable "window_size" {
  type        = string
  description = "(Optional) The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than frequency. Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. Defaults to PT5M."
  default     = "PT5M"
  validation {
    condition     = contains(["PT1M", "PT5M", "PT15M", "PT30M", "PT1H", "PT6H", "PT12H", "P1D"], var.window_size)
    error_message = "Variable \"window_size\" must either be PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. Default is PT5M."
  }
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}