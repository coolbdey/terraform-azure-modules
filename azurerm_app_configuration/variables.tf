variable "name" {}
variable "rg_name" {}
variable "sku" {
  type        = string
  description = "(Optional) The SKU name of the the App Configuration. Possible values are free and standard."
  default     = "standard"
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
