

variable "tenant_id" {}
variable "client_id" {}
variable "client_secret" {}

variable "name" {}
variable "login_name" {}
variable "db_name" {}
variable "roles" {
  type    = list(string)
  default = ["db_owner"]
}
variable "port" {
  type    = number
  default = 1433
}
variable "default_language" {
  type    = string
  default = "us_english"
}
variable "default_schema" {
  type    = string
  default = "dbo"
}
variable "sql_name" {}
variable "rg_name" {}
variable "kv_name" {}

