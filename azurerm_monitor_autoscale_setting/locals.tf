locals {
  target_types = {
    "app_service_plan" = {
      metric_name      = "CpuPercentage"
      metric_namespace = "Microsoft.Web/serverfarms"
    }
    "virtual_machine_scale_set" = {
      metric_name      = "Percentage CPU"
      metric_namespace = "microsoft.compute/virtualmachinescalesets"
    }
  }
  metric_name      = local.target_types[var.target_type].metric_name
  metric_namespace = local.target_types[var.target_type].metric_namespace
}
