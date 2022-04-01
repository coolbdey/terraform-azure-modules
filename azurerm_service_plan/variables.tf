variable "name" {}
variable "rg_name" {}
variable "os_type" {
  type        = string
  description = "(Required) The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer."
  default     = "Windows"
  validation {
    condition     = can(regex("Windows|Linux|WindowsContainer", var.os_type))
    error_message = "Variable 'os_type' must either be Windows (Default), Linux, or WindowsContainer."
  }
}
variable "sku_name" {
  type        = string
  description = "(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, and WS3."
  default     = "Standard"
}
variable "app_service_environment_id" {
  type        = string
  description = "(Optional) The ID of the App Service Environment to create this Service Plan in."
  default     = null
}
variable "worker_count" {
  type        = number
  description = "(Optional) The number of Workers (instances) to be allocated."
  default     = 2
}
variable "maximum_elastic_worker_count" {
  type        = number
  description = "(Optional) The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU."
  default     = 1
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
