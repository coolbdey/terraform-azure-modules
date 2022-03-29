variable "name" {}
variable "rg_name" {}
variable "enabled" {
  type        = bool
  description = "(Optional) Specifies whether automatic scaling is enabled for the target resource. Defaults to true."
  default     = true
}
variable "target_resource_id" {
  type        = string
  description = "(Required) Specifies the resource ID of the resource that the autoscale setting should be added to. Either App Service Plan ID or Virtual Machine Scale Set ID"
  validation {
    condition     = can(regex("appserviceplan|serverfarms|virtualMachineScaleSets", var.target_resource_id))
    error_message = "Variable 'target_resource_id' must be the ID of either AppServicePlan or virtualMachineScaleSets."
  }
}
variable "profiles" {
  type = list(object({
    name = string
    capacity = object({
      default = number # (Required) The number of instances that are available for scaling if metrics are not available for evaluation. The default is only used if the current instance count is lower than the default. Valid values are between 0 and 1000.
      minimum = number # (Required) The maximum number of instances for this resource. Valid values are between 0 and 1000.
      maximum = number # (Required) The minimum number of instances for this resource. Valid values are between 0 and 1000.
    })
    rules = list(object({
      metric_trigger = object({
        metric_name        = string # (Required) The name of the metric that defines what the rule monitors, such as Percentage CPU for Virtual Machine Scale Sets and CpuPercentage for App Service Plan. https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported
        metric_resource_id = string # (Required) The ID of the Resource which the Rule monitors
        operator           = string # (Required) Specifies the operator used to compare the metric data and threshold. Possible values are: Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan, LessThanOrEqual.
        statistic          = string # (Required) Specifies how the metrics from multiple instances are combined. Possible values are Average, Min and Max.
        time_aggregation   = string # (Required) Specifies how the data that's collected should be combined over time. Possible values include Average, Count, Maximum, Minimum, Last and Total. Defaults to Average.
        time_grain         = string # (Required) Specifies the granularity of metrics that the rule monitors, which must be one of the pre-defined values returned from the metric definitions for the metric. This value must be between 1 minute and 12 hours an be formatted as an ISO 8601 string. Ex: PT1M
        time_window        = string # (Required) Specifies the time range for which data is collected, which must be greater than the delay in metric collection (which varies from resource to resource). This value must be between 5 minutes and 12 hours and be formatted as an ISO 8601 string. Ex: PT5M
        threshold          = number # (Required) Specifies the threshold of the metric that triggers the scale action. Ex: 90
        dimensions = list(object({
          name     = string       # (Required) The name of the dimension.
          operator = string       # (Required) The dimension operator. Possible values are Equals and NotEquals. Equals means being equal to any of the values. NotEquals means being not equal to any of the values.
          values   = list(string) # (Required) A list of dimension values.
        }))
        # TODO: divide_by_instance_count
      })
      scale_action = object({
        cooldown  = string # (Required) The amount of time to wait since the last scaling action before this action occurs. Must be between 1 minute and 1 week and formatted as a ISO 8601 string. Ex: PT1M 
        direction = string # (Required) The scale direction. Possible values are Increase and Decrease
        type      = string # (Required) The type of action that should occur. Possible values are ChangeCount, ExactCount, PercentChangeCount and ServiceAllowedNextValue
        value     = number # (Required) The number of instances involved in the scaling action. Defaults to 1.
      })
    }))
    # (Optional) A fixed_date block as defined below. This cannot be specified if a recurrence block is specified.
    fixed_date = object({
      enabled  = bool   # Either fixed_date.enabled or recurrence.enabled 
      timezone = string # (Optional) The Time Zone of the start and end times. A list of possible values can be found https://msdn.microsoft.com/en-us/library/azure/dn931928.aspx. Defaults to UTC. Ex: Pacific Standard Time
      start    = string # (Required) Specifies the start date for the profile, formatted as an RFC3339 date string. Ex: 2020-07-01T00:00:00Z
      end      = string # (Required) Specifies the start date for the profile, formatted as an RFC3339 date string. Ex: 2020-07-31T23:59:59Z
    })
    # (Optional) A recurrence block as defined below. This cannot be specified if a fixed_date block is specified.
    recurrence = object({
      enabled  = bool
      timezone = string       # (Required) The Time Zone used for the hours field. A list of possible values can be found https://msdn.microsoft.com/en-us/library/azure/dn931928.aspx. Defaults to UTC
      days     = list(string) # (Required) A list of days that this profile takes effect on. Possible values include Monday, Tuesday, Wednesday, Thursday, Friday, Saturday and Sunday
      hours    = list(number) # (Required) A list containing a single item, which specifies the Hour interval at which this recurrence should be triggered (in 24-hour time). Possible values are from 0 to 23. Ex: [12]
      minutes  = list(number) # (Required) A list containing a single item which specifies the Minute interval at which this recurrence should be triggered. Ex: [0]
    })
  }))
  description = "Up to 20 profiles, at least 1. Up to 10 rules"
  validation {
    condition     = length(var.profiles) >= 1 && length(var.profiles) <= 20 && length(var.profiles[0].rules) >= 1 && length(var.profiles[0].rules) <= 10
    error_message = "Variable 'profiles' must at least be 1 up to 20. Rules must be 1 up 10."
  }
}

variable "notification" {
  type = object({
    email = object({
      send_to_subscription_administrator    = bool         # (Optional) Should email notifications be sent to the subscription administrator? Defaults to false.
      send_to_subscription_co_administrator = bool         # (Optional) Should email notifications be sent to the subscription co-administrator? Defaults to false.
      custom_emails                         = list(string) # (Optional) Specifies a list of custom email addresses to which the email notifications will be sent.
    })
    webhooks = list(object({
      service_uri = string   # (Required) The HTTPS URI which should receive scale notifications.
      properties  = map(any) # Optional) A map of settings
    }))
  })
  description = "Send notification emails"
  default = {
    email = {
      send_to_subscription_administrator    = false
      send_to_subscription_co_administrator = false
      custom_emails                         = []
    }
    webhooks = []
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

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}