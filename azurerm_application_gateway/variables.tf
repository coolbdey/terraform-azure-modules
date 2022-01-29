variable "name" {}
variable "rg_name" {}
variable "tier" {
  type        = string
  description = " (Required) The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2."
  default     = "Standard" # WAF
}
variable "sku" {
  type = string

  default = "Standard_Small" # WAF_Medium
}

variable "capacity" {
  type        = number
  description = "(Required) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set."
  default     = 2
}
variable "max_capacity" {
  type        = number
  description = "(Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125."
  default     = 2
}
variable "min_capacity" {
  type        = number
  description = "(Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100."
  default     = 1
}
variable "rewrite_rules" {
  type = list(object({
    name          = string
    rule_sequence = string
    condition = list(object({
      variable    = string
      pattern     = string
      ignore_case = bool
      negate      = bool
    }))
    request_header_configuration = list(object({
      header_name  = string
      header_value = string
    }))
    response_header_configuration = list(object({
      header_name  = string
      header_value = string
    }))
    url = list(object({
      path         = string
      query_string = string
      reroute      = string
    }))
  }))
  description = "Rewrite rule sequence. https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway"
  default     = []
}
variable "vnet_name" {}
variable "vnet_rg_name" {}
variable "snet_name" {}
variable "pipa_name" {}
variable "pipa_rg_name" {}

#variable "cert_file" {

#}
variable "identity_ids" {
  type        = list(string)
  description = "(Required) Specifies a list with a single user managed identity id to be assigned to the Application Gateway."
  default     = []
}
variable "kv_secret_id" {
  type        = string
  description = " (Optional) Secret Id of (base-64 encoded unencrypted pfx) Secret or Certificate object stored in Azure KeyVault. You need to enable soft delete for keyvault to use this feature. Required if data is not set."
  # For TLS termination with Key Vault certificates to work properly existing user-assigned managed identity, 
  # which Application Gateway uses to retrieve certificates from Key Vault, should be defined via identity block. 
  # Additionally, access policies in the Key Vault to allow the identity to be granted get access to the secret should be defined.
}
variable "ssl_cert_name" {
  type        = string
  description = "(Required) The Name of the SSL certificate that is unique within this Application Gateway and exist in the Key Vault"
}
variable "host_names" {
  type        = list(string)
  description = "List of http_listener host names. Supports wildcard. Example *.domain.com"
  default     = []
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
