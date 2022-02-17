variable "name" {}
variable "short_name" {
  type        = string
  description = "A short display name of the action group, 1-12 in length"
  validation {
    condition     = length(var.short_name) >= 1 && length(var.short_name) <= 12
    error_message = "The variable 'short_name' length must be withing range 1-12."
  }

}
variable "rg_name" {}
variable "enabled" {
  type        = bool
  description = "(Optional) Whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications. Defaults to true"
  default     = true
}

variable "automation_runbook_receiver" {
  type = list(object({
    name                    = string
    automation_account_id   = string
    runbook_name            = string
    webhook_resource_id     = string
    is_global_runbook       = bool
    service_uri             = string
    use_common_alert_schema = bool
  }))
  description = "Action group for Automatic RunBook Reciever(s)"
  default     = []

  #validation {
  #  condition = alltrue([
  #    for item in var.connection_strings : can(regex("^SQLAzure$|^SQLServer$|^Custom$|^PIHub$|`^DocDb$|^EventHub$|^MySQL$|^NotificationHub$|^PostgreSQL$|^RedisCache$|^ServiceBus$", item.type))
  #  ])
  #  error_message = "The variable 'connection_strings' must have valid type: 'SQLAzure', 'SQLServer', 'Custom', .. ."
  #}
}

variable "azure_app_push_receiver" {
  type = list(object({
    name          = string
    email_address = string
  }))
  description = "Action group for App Push Reciever(s)"
  default     = []
}

variable "azure_function_receiver" {
  type = list(object({
    name                     = string
    function_app_resource_id = string
    function_name            = string
    http_trigger_url         = string
    use_common_alert_schema  = bool
  }))
  description = "Action group for Function reciever(s)"
  default     = []
}

variable "email_receiver" {
  type = list(object({
    name                    = string
    email_address           = string
    use_common_alert_schema = bool
  }))
  description = "Action group for Email Reciever(s)"
  default     = []
}

variable "event_hub_receiver" {
  type = list(object({
    name                    = string
    event_hub_id            = string
    use_common_alert_schema = bool
  }))
  description = "Action group for Hub Reciever(s)"
  default     = []

}

variable "itsm_receiver" {
  type = list(object({
    name          = string
    workspace_id  = string
    connection_id = string
    region        = string
    #ticket_configuration
    #use_common_alert_schema = bool
  }))
  description = "Action group for (s)"
  default     = []

}

variable "logic_app_receiver" {
  type = list(object({
    name                    = string
    resource_id             = string
    callback_url            = string
    use_common_alert_schema = bool
  }))
  description = "Action group for (s)"
  default     = []

}

variable "sms_receiver" {
  type = list(object({
    name         = string
    country_code = number
    phone_number = number
  }))
  description = "Action group for (s)"
  default     = []

}
variable "voice_receiver" {
  type = list(object({
    name         = string
    country_code = number
    phone_number = number
  }))
  description = "Action group for (s)"
  default     = []

}

variable "webhook_receiver" {
  type = list(object({
    name                    = string
    service_uri             = string
    use_common_alert_schema = bool
  }))
  description = "Action group for (s)"
  default     = []

}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}