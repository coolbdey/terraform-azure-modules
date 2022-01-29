variable "name" {}
variable "location" {
  type = string
  # "The provided location 'norwayeast' is not available for resource type 'Microsoft.Cdn/profiles'. List of available regions for the resource type is 'global,australiaeast,australiasoutheast,brazilsouth,canadacentral,canadaeast,centralindia,centralus,eastasia,eastus,eastus2,japaneast,japanwest,northcentralus,northeurope,southcentralus,southindia,southeastasia,westeurope,westindia,westus,westcentralus'"
  description = "The location for CDN Endpoint"
  default     = "global"
}
variable "rg_name" {}
variable "sa_name" {}
variable "cdnp_name" {}
variable "origin_name" {
  type        = string
  description = "(Required) The name of the origin. This is an arbitrary value. However, this value needs to be unique under the endpoint. Changing this forces a new resource to be created."
  default     = "origin-0"
}
variable "origin_host" {
  type        = string
  description = "(Required) A string that determines the hostname/IP address of the origin server. This string can be a domain name, Storage Account endpoint, Web App endpoint, IPv4 address or IPv6 address. Changing this forces a new resource to be created."
}
variable "origin_path" {
  type        = string
  description = "The path (container on the origin_host - storage account ) used at for origin requests"
}
variable "content_types_to_compress" {
  type        = list(string)
  description = "(Optional) An array of strings that indicates a content types on which compression will be applied. The value for the elements should be MIME types"
  default     = ["text/plain", "text/html", "text/css", "text/javascript", "application/x-javascript", "application/javascript", "application/json", "application/xml"]
}
variable "is_compression_enabled" {
  type        = bool
  description = "(Optional) Indicates whether compression is to be enabled."
  default     = false
}
variable "custom_domain" {
  type        = string
  description = "(Required) The name which should be used for this CDN Endpoint Custom Domain. Changing this forces a new CDN Endpoint Custom Domain to be created."
  default     = ""
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
