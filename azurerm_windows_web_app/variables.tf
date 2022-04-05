variable "enabled" {
  type        = bool
  description = "Is the App Service Enabled?"
  default     = true
}
variable "always_on" {
  type        = bool
  description = "#(Optional) If this Windows Web App is Always On enabled. Defaults to true."
  default     = true
}
variable "name" {}
variable "rg_name" {}
variable "sp_name" {}
variable "sa_name" {}
variable "managed_identity_type" {
  type        = string
  description = "(Optional) The type of Managed Identity which should be assigned to the Linux Virtual Machine Scale Set. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`"
  default     = null
  validation {
    condition     = can(regex("^SystemAssigned$|^UserAssigned$|^SystemAssigned, UserAssigned$", var.managed_identity_type))
    error_message = "The variable 'managed_identity_type' must be: SystemAssigned, or UserAssigned or `SystemAssigned, UserAssigned`."
  }
}
variable "managed_identity_ids" {
  type        = list(string)
  description = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Windows Virtual Machine Scale Set."
  default     = []
}
variable "auth_settings" {
  type = list(object({
    enabled          = bool
    default_provider = string # (Optional) The default authentication provider to use when multiple providers are configured. Possible values include: AzureActiveDirectory, Facebook, Google, MicrosoftAccount, Twitter, Github
    active_directory = object({
      client_id     = string
      client_secret = string
      audiences     = list(string)
    })
  }))
  description = "Authentication Settings"
  default     = []
}
variable "backup" {
  type = object({
    name                = string # (Required) Specifies the name for this Backup
    enabled             = bool   # (Required) Is this Backup enabled?
    storage_account_url = string
    schedule = object({
      frequency_interval       = string # (Required) Sets how often the backup should be executed.
      frequency_unit           = string # (Optional) Sets the unit of time for how often the backup should be executed. Possible values are Day or Hour.
      keep_at_least_one_backup = bool   # (Optional) Should at least one backup always be kept in the Storage Account by the Retention Policy, regardless of how old it is?
      retention_period_in_days = string # (Optional) Specifies the number of days after which Backups should be deleted.
      start_time               = string # (Optional) Sets when the schedule should start working.
    })
  })
  description = "Backup for the App Service"
  default = {
    name                = "backup"
    enabled             = false
    storage_account_url = null
    schedule = {
      frequency_interval       = 1
      frequency_unit           = "Day"
      keep_at_least_one_backup = false
      retention_period_in_days = 1
      start_time               = null
    }
  }
}
variable "app_insights" {
  type = object({
    enabled             = bool
    instrumentation_key = string
    connection_string   = string
  })
  description = "Aplication insights"
  default = {
    enabled             = false
    instrumentation_key = null
    connection_string   = null
  }
}
variable "connection_strings" {
  type = list(object({
    type = string # (Required) Type of database. Possible values include: APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure, and SQLServer.
    conn = string # (Required) The connection string value.
  }))
  description = "A list of connectionstrings"
  default     = []

  validation {
    condition = alltrue([
      for item in var.connection_strings : can(regex("^SQLAzure$|^SQLServer$|^Custom$|^PIHub$|`^DocDb$|^EventHub$|^MySQL$|^NotificationHub$|^PostgreSQL$|^RedisCache$|^ServiceBus$", item.type))
    ])
    error_message = "The variable 'connection_strings' must have valid type: 'SQLAzure', 'SQLServer', 'Custom', .. ."
  }
}

variable "client_affinity_enabled" {
  type        = bool
  description = "(Optional) Should Client Affinity be enabled?"
  default     = false
}
variable "client_certificate_enabled" {
  type        = bool
  description = "(Optional) Should the function app use Client Certificates."
  default     = false
}
variable "client_certificate_mode" {
  type        = string
  description = "(Optional) The Client Certificate mode. Possible values include Optional and Required. This property has no effect when client_cert_enabled is false."
  default     = "Optional"
  validation {
    condition     = can(regex("^Required$|^Optional$", var.client_certificate_mode))
    error_message = "The variable 'client_cert_mode' must have value storage_account_type: Required, or  Optional (Default)."
  }
}
variable "auto_heal_enabled" {
  type        = bool
  description = "(Optional) Should Auto heal rules be enabled. Required with auto_heal_setting."
  default     = false
}
variable "auto_heal_setting" {
  type = object({
    action = object({
      action_type                    = string # (Required) Predefined action to be taken to an Auto Heal trigger. Possible values include: Recycle, LogEvent, and CustomAction
      custom_data                    = string # (Optional) A custom_action block as defined below.
      minimum_process_execution_time = string # (Optional) The minimum amount of time in hh:mm:ss the Windows Web App must have been running before the defined action will be run in the event of a trigger.
    })
    trigger = object({
      private_memory_kb = number
      requests = object({
        count    = string # (Required) The number of requests in the specified interval to trigger this rule.
        interval = string # (Required) The interval in hh:mm:ss.
      })
      slow_request = object({
        count      = string # (Required) The number of Slow Requests in the time interval to trigger this rule.
        interval   = string # (Required) The time interval in the form hh:mm:ss.
        time_taken = string # (Required) The threshold of time passed to qualify as a Slow Request in hh:mm:ss.
        path       = string # (Optional) The path for which this slow request rule applies.
      })
      status_code = object({
        count             = number # (Required) The number of occurrences of the defined status_code in the specified interval on which to trigger this rule.
        interval          = string # (Required) The time interval in the form hh:mm:ss.
        status_code_range = number # (Required) The status code for this rule, accepts single status codes and status code ranges. e.g. 500 or 400-499. Possible values are integers between 101 and 599
        path              = string # (Optional) The path to which this rule status code applies.
        sub_status        = string # (Optional) The Request Sub Status of the Status Code.
        win32_status      = string # (Optional) The Win32 Status Code of the Request.
      })
    })
  })
  description = "(Optional) Should Auto heal rules be enabled. Required with auto_heal_setting."
  default     = null
}
variable "cors" {
  type = object({
    enabled             = bool
    allowed_origins     = list(string) # (Required) Specifies a list of origins that should be allowed to make cross-origin calls.
    support_credentials = bool         # (Optional) Whether CORS requests with credentials are allowed. Defaults to false
  })
  description = "Cross-Origin Resource Sharing (CORS) allows JavaScript code running in a browser on an external host to interact with your backend"
  default = {
    enabled             = false
    allowed_origins     = ["*"]
    support_credentials = true
  }
}
variable "ftps_state" {
  type        = string
  description = "(Optional) State of FTP / FTPS service for this App Service. Possible values include: AllAllowed, FtpsOnly and Disabled. AppService log requires this to be activated."
  default     = "FtpsOnly"
  validation {
    condition     = contains(["Disabled", "FtpsOnly", "AllAllowed"], var.ftps_state)
    error_message = "Variable \"ftps_state\" must either be \"Disabled\", \"FtpsOnly\" or \"AllAllowed\"."
  }
}
variable "websockets" {
  type        = bool
  description = "(Optional) Should Web Sockets be enabled. Defaults to false."
  default     = false
}
variable "http2_enabled" {
  type        = bool
  description = "(Optional) Specifies if the http2 protocol should be enabled. Defaults to false."
  default     = false
}
variable "app_scale_limit" {
  type        = number
  description = "(Optional) The number of workers this function app can scale out to. Only applicable to apps on the Consumption and Premium plan."
  default     = null
}
variable "health_check_path" {
  type        = string
  description = "(Optional) Path which will be checked for this function app health. "
  default     = null
}

variable "https_only" {
  type        = bool
  description = "Can the App Service only be accessed via HTTPS?"
  default     = false
}
variable "worker_count" {
  type        = number
  description = "(Optional) The number of Workers (instances) to be allocated."
  default     = 2
}

variable "application_logs" {
  type = object({
    enabled = bool
    azure_blob_storage = object({
      level             = string # (Required) The level at which to log. Possible values include Error, Warning, Information, Verbose and Off. NOTE: this field is not available for http_logs
      sas_url           = string # (Required) The URL to the storage container with a shared access signature token appended.
      retention_in_days = number # (Required) The number of days to retain logs for.
    })
    file_system_level = string # (Optional) Log level for filesystem based logging. Supported values are Error, Information, Verbose, Warning and Off. Defaults to Off.
  })
  description = "Application logs for the App Service"
  default = {
    enabled = false
    azure_blob_storage = {
      level             = "Off"
      sas_url           = null
      retention_in_days = 10
    }
    file_system_level = "Off"
  }
}
variable "http_logs" {
  type = object({
    enabled = bool
    file_system = object({
      retention_in_days = number # (Required) The number of days to retain logs for.
      retention_in_mb   = number # (Required) The maximum size in megabytes that http log files can use before being removed. 
    })
    azure_blob_storage = object({
      sas_url           = string
      retention_in_days = number
    })
  })
  description = "HTTP logs for the App Service"
  default = {
    enabled = false
    file_system = {
      retention_in_days = 1
      retention_in_mb   = 10
    }
    azure_blob_storage = {
      sas_url           = null
      retention_in_days = 10
    }
  }
}
variable "detailed_error_messages_enabled" {
  type        = bool
  description = "(Optional) Should Detailed error messages be enabled on this App Service? Default is false."
  default     = false
}
variable "failed_request_tracing_enabled" {
  type        = bool
  description = "(Optional) Should Failed request tracing be enabled on this App Service? Defaults to false."
  default     = false
}
variable "dotnet_version" {
  type        = number
  description = "(Optional) The version of .Net to use. Possible values include 3.1 and 6.0."
  default     = 3.1
  validation {
    condition     = contains(["3.1", "6.0"], var.dotnet_version)
    error_message = "Variable 'dotnet_version' must either be 3.1 (Default) or 6.0."
  }
}

variable "use_dotnet_isolated_runtime" {
  type        = bool
  description = "(Optional) Should the DotNet process use an isolated runtime. Defaults to false."
  default     = false
}

variable "java_version" {
  type        = number
  description = "(Optional) The version of Java to run. Possible values include 8 and 11."
  default     = null
  validation {
    condition     = contains(["8", "11"], var.java_version)
    error_message = "Variable 'java_version' must either be 8 or 11."
  }
}

variable "python_version" {
  type        = number
  description = "(Optional) The version of Python to run. Possible values include 3.6, 3.7, 3.8 and 3.9."
  default     = null
  validation {
    condition     = contains(["3.6", "3.7", "3.8", "3.9"], var.python_version)
    error_message = "Variable 'python_version' must either be 3.6, 3.7, 3.8 or 3.9."
  }
}

variable "node_version" {
  type        = number
  description = "(Optional) The version of Node to run. Possible values include 12, 14 and 16."
  default     = null
  validation {
    condition     = contains(["~12", "~14", "~16"], var.node_version)
    error_message = "Variable 'node_version' must either be ~12, ~14 or ~16."
  }
}
variable "powershell_version" {
  type        = number
  description = "(Optional) The version of Powershell Core to run. Possible values are 7."
  default     = 7
  validation {
    condition     = contains(["7"], var.powershell_version)
    error_message = "Variable 'powershell_version' must be 7."
  }
}

variable "use_custom_runtime" {
  type        = bool
  description = "(Optional) Should the Linux Function App use a custom runtime?"
  default     = true
}

variable "app_settings" {
  type        = map(string)
  description = "Map of App Settings. This will be merged with default app settings"
  default     = {}
}
variable "ip_restrictions" {
  type = list(object({
    name                      = string
    action                    = string # (Optional) The action to take. Possible values are Allow or Deny.
    priority                  = number # (Optional) The priority value of this ip_restriction.
    ip_address                = string # (Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
    virtual_network_subnet_id = string # (Optional) The Virtual Network Subnet ID used for this IP Restriction.
    service_tag               = string # (Optional) The Service Tag used for this IP Restriction
    headers = list(object({
      x_azure_fdid      = set(string)
      x_fd_health_probe = set(string)
      x_forwarded_for   = set(string)
      x_forwarded_host  = set(string)
    }))
  }))
  description = "The IP Address used for this IP Restriction. One of either ip_address, service_tag or virtual_network_subnet_id must be specified. IP_address should be CIDR or IP-address/32"
  default     = []
}
variable "use_32_bit_worker" {
  type        = bool
  description = "(Optional) Should the Linux Web App use a 32-bit worker process. Defaults to true."
  default     = false
}
variable "load_balancing_mode" {
  type        = string
  description = "(Optional) The Site load balancing. Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests if omitted."
  default     = "LeastRequests"
  validation {
    condition     = can(regex("WeightedRoundRobin|LeastRequests|LeastResponseTime|WeightedTotalTraffic|RequestHash|PerSiteRoundRobin", var.load_balancing_mode))
    error_message = "variable 'load_balancing_mode' must be either WeightedRoundRobin, LeastRequests (Default), LeastResponseTime, WeightedTotalTraffic, RequestHash, or PerSiteRoundRobin."
  }
}
variable "managed_pipeline_mode" {
  type        = string
  description = "(Optional) Managed pipeline mode. Possible values include: Integrated, Classic."
  default     = "Integrated"
  validation {
    condition     = can(regex("Integrated|Classic", var.managed_pipeline_mode))
    error_message = "variable 'load_balancing_mode' must be either Integrated (Default), or Classic."
  }
}
variable "minimum_tls_version" {
  type        = number
  description = "(Optional) Configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2."
  default     = 1.2
  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "variable 'minimum_tls_version' must be either 1.0, 1.1 or 1.2 (Default)."
  }
}

variable "storage_account" {
  type = list(object({
    access_key   = string # (Required) The Access key for the storage account.
    account_name = string # (Required) The Name of the Storage Account.
    name         = string #  (Required) The name which should be used for this TODO.
    share_name   = string #  (Required) The Name of the File Share or Container Name for Blob storage.
    type         = string #  (Required) The Azure Storage Type. Possible values include AzureFiles and AzureBlob
    mount_path   = string #  (Optional) The path at which to mount the storage share.
  }))
  description = "Storage accounts"
  default     = []
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}