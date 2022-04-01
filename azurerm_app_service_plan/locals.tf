locals {
  # Activates Consumption plan
  tier = var.kind == "FunctionApp" ? "Dynamic" : var.kind
  size = var.kind == "FunctionApp" ? "Y1" : var.size
}