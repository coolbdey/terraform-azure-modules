variable "name" {}
variable "rg_name" {}
variable "location" {
  type        = string
  description = "The Location for Static website. List of available regions are: westus2,centralus,eastus2,westeurope or eastasia"
  default     = "westeurope"
  validation {
    condition     = contains(["westus2", "centralus", "eastus2", "westeurope", "eastasia"], var.location)
    error_message = "Variable \"location\" must either be westus2, centralus, eastus2, westeurope or eastasia."
  }
}
variable "sku_tier" {
  type        = string
  description = "- (Optional) Specifies the sku tier of the Static Web App. Possible values are Free or Standard. Defaults to Free."
  default     = "Free"
  validation {
    condition     = contains(["Free", "Standard"], var.sku_tier)
    error_message = "Variable \"sku_tier\" must either be \"Free\", or \"Standard\"."
  }
}
variable "sku_size" {
  type        = string
  description = "- (Optional) Specifies the sku size of the Static Web App. Possible values are Free or Standard. Defaults to Free."
  default     = "Free"
  validation {
    condition     = contains(["Free", "Standard"], var.sku_size)
    error_message = "Variable \"sku_size\" must either be \"Free\", or \"Standard\"."
  }
}
variable "identity_ids" {
  type = list(string)
  description = "(Optional) A list of Managed Identity ID's which should be assigned to this Static Site resource."
  default = []
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
