variable "name" {}
variable "rg_name" {}
variable "location" {
  type        = string
  description = "The the location for the storage account. If omittted then the resource group will be used"
  default     = ""
}
variable "containers" {
  type = list(object({
    category    = string
    name        = string
    access_type = string
  }))
  description = "Manages a Container within Azure Storage."
  default     = []
}
variable "shares" {
  type = list(object({
    name        = string
    quota       = number
    permissions = string
  }))
  description = "Manages a File Share within Azure Storage. The permissions which should be associated with this Shared Identifier has a combination of r (read), w (write), d (delete), and l (list)"
  default     = []
}
variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created."
  default     = "StorageV2"
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa"
  default     = "LRS"
}

variable "access_tier" {
  type        = string
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool."
  default     = "Hot"
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2."
  default     = "TLS1_2"
}
variable "infrastructure_encryption_enabled" {
  type        = bool
  description = "(Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false"
  default     = false
}

variable "retention_in_days" {
  type        = number
  description = "Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 35. Must be higher than softdelete"
  default     = 35
}
variable "enable_rbac_authorization" {
  type        = bool
  description = "Activates RBAC on the resource"
  default     = false
}
variable "rbac_roles" {
  type = list(object({
    role_definition_name = string
    principal_id         = string
  }))
  description = "Role definition name to give access to, ex: Storage Blob Data Contributor. Note: var.enable_rbac_authorization must be true"
  default     = []
}

variable "cors_rules" {
  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  description = "Blob, share, queue and table CORS rule properties"
  default     = []
}
variable "network_rules" {
  type = object({
    default_action             = string       # (Required) Specifies the default action of allow or deny when no other rules match.
    bypass                     = list(string) # (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
    ip_rules                   = list(string) # (Optional) List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed.
    virtual_network_subnet_ids = list(string)
    private_link_access = list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = string
    }))
  })
  description = "(Required) Network rules for the storage account."
  default = {
    default_action             = "Allow"
    bypass                     = ["Logging", "AzureServices", "Metrics"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
    private_link_access        = []
  }
  validation {
    condition = alltrue([
      for item in var.network_rules.default_action : can(regex("^Allow$|^Deny$", item.default_action))
    ])
    error_message = "The variable 'network_rules.default_action' must have valid default_action: 'Allow', 'Deny' ."
  }
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
