
variable "name" {}
variable "rg_name" {}
variable "location" {
  type = string
  # "The provided location 'norwayeast' is not available for resource type 'Microsoft.Cdn/profiles'. List of available regions for the resource type is 'global,australiaeast,australiasoutheast,brazilsouth,canadacentral,canadaeast,centralindia,centralus,eastasia,eastus,eastus2,japaneast,japanwest,northcentralus,northeurope,southcentralus,southindia,southeastasia,westeurope,westindia,westus,westcentralus'"
  description = "The location for CDN profile "
  default     = "global"
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
