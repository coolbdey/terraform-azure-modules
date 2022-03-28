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
  is_vmss          = can(regex("virtualmachinescaleset", var.target_resource_id))
  metric_namespace = local.is_vmss ? "microsoft.compute/virtualmachinescalesets" : "Microsoft.Web/serverfarms" # (Optional) The namespace of the metric that defines what the rule monitors, such as microsoft.compute/virtualmachinescalesets for Virtual Machine Scale Sets.
}
