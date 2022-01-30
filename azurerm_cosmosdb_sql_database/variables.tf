variable "name" {}
variable "rg_name" {}
variable "cdba_name" {}
variable "throughout" {
  type        = number
  description = "(Optional) The throughput of the MongoDB database (RU/s). Must be set in increments of 100. The minimum value is 400. Maximum value of 1000000. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  default     = 400
}

