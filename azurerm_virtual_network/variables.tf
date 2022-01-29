variable "name" {}
variable "rg_name" {}
variable "dpp_name" {}
variable "dpp_enabled" {
  type        = bool
  description = "Azure DDoS Protection is very expensive.https://azure.microsoft.com/en-us/pricing/calculator/. Only one resource supported per Subscription"
  default     = false
}
variable "nw_name" {}
variable "address_space" {}
variable "use_azure_dns" {
  type    = bool
  default = true
}
variable "dns_servers" {
  type    = list(string)
  default = []
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
