variable "name" {}
variable "rg_name" {}
variable "target_resource_id" {
  type        = string
  description = "(Required) Specifies the resource ID of the resource that the autoscale setting should be added to."
}
variable "target_type" {
  type        = string
  description = "Specifies the scale module name. Choices are app_service_plan and virtual_machine_scale_set"
  default     = "app_service_plan"
  validation {
    condition     = contains(["app_service_plan", "virtual_machine_scale_set"], var.target_type)
    error_message = "Variable \"apptarget_type_type\" must either be \"winapp_service_plandows\" or \"virtual_machine_scale_set\"."
  }

}
variable "capacity_max" {
  type        = number
  description = "(Required) The maximum number of instances for this resource. Valid values are between 0 and 1000."
  default     = 10
}
variable "capacity_min" {
  type        = number
  description = "(Required) The minimum number of instances for this resource. Valid values are between 0 and 1000"
  default     = 1
}
variable "notification_enabled" {
  type        = bool
  description = "Enable sending notification emails"
  default     = false
}
variable "notification_emails" {
  type        = list(string)
  description = "(Optional) Specifies a list of custom email addresses to which the email notifications will be sent."
  default     = []
}
variable "threshold_high" {
  type        = number
  description = "(Required) Specifies the upper threshold of the metric that triggers the scale action."
  default     = 75
}
variable "threshold_low" {
  type        = number
  description = "(Required) Specifies the lower threshold of the metric that triggers the scale action."
  default     = 25
}
