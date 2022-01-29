

variable "tenant_id" {}
variable "client_id" {}
variable "client_secret" {}

variable "login_name" {}
variable "password" {
  type      = string
  sensitive = true
}
variable "port" {
  type    = number
  default = 1433
}
variable "default_database" {
  type    = string
  default = "master"
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


