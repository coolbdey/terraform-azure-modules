variable "name" {}
variable "rg_name" {}
variable "sku_tier" {
  type        = string
  description = "- (Optional) Specifies the sku tier of the Static Web App. Possible values are Free or Standard. Defaults to Free."
  default     = "Free"
  validation {
    condition     = contains(["Free", "Standard"], var.sku_size)
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
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
